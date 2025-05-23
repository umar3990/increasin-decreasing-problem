class ZipDownloaderLambda
  DEFAULT_REGION = 'us-east-1'.freeze

  def initialize(encryption_key:, id:, directories:, files:, zip_filename:, update_callback:, io_or_urls: 'urls')
    @encryption_key = encryption_key

    @command = OpenStruct.new(
      id: id,
      directories: directories,
      files: files,
      zip_filename: zip_filename,
      io_or_urls: io_or_urls
    )
  end

  def invoke_lambda
    begin
      @dir = Dir.new(Dir.mktmpdir)
      response_object = {
        directory: @dir
      }

      lambda_url = ENV.fetch('LAMBDA_FUNCTION_URL', nil)
      unless lambda_url
        puts "Error: LAMBDA_FUNCTION_URL environment variable is not set."
        return { error: "LAMBDA_FUNCTION_URL environment variable is not set." }
      end

      file_storage = FileStorage.new(encryption_key: @encryption_key)
      response_object[:zip_filename] = @command.zip_filename

      request_body = build_request_body(file_storage)

      update_callback.("compiling_zip")
      response = send_lambda_request(lambda_url, request_body)
      update_callback.("uploading")

      parse_lambda_response(response, response_object)
    rescue => e
      update_callback.("failed", "failed")
      raise e
    ensure
      unless @keep_dir
        FileUtils.rm_rf(@dir) if @dir
      end
    end
  end

  private

  def build_request_body(file_storage)
    {
      zip_upload_bucket: file_storage.determine_bucket(:zip_upload),
      source_files_bucket: file_storage.determine_bucket,
      region_name: DEFAULT_REGION,
      zip_file_name: @command.zip_filename,
      files: @command.files
    }.to_json
  end

  def send_lambda_request(lambda_url, request_body)
    uri = URI(lambda_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.read_timeout = 300

    request = Net::HTTP::Post.new(uri)
    request['Content-Type'] = 'application/json'
    request.body = request_body

    begin
      http.request(request)
    rescue StandardError => e
      puts "HTTP request to Lambda failed: #{e.message}"
      raise e
    end
  end

  def parse_lambda_response(response, response_object)
    if response.is_a?(Net::HTTPSuccess)
      puts "Lambda response: #{response.body}"
      response_object[:public_url] = response.body
      response_object
    else
      puts "Lambda error: #{response.code} - #{response.message}"
      { error: response.message, status: response.code }
    end
  end

  def update_callback
    @update_callback ||= lambda do |status, flag=nil|
    end
  end
end
