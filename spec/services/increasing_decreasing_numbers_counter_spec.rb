# spec/services/increasing_decreasing_numbers_counter_spec.rb
require 'rails_helper'

RSpec.describe IncreasingDecreasingNumbersCounter do
  describe '.call' do
    it 'returns 1 for power 0' do
      expect(IncreasingDecreasingNumbersCounter.call(0)).to eq(1)
    end

    it 'returns 10 for power 1' do
      expect(IncreasingDecreasingNumbersCounter.call(1)).to eq(10)
    end

    it 'returns 100 for power 2' do
      expect(IncreasingDecreasingNumbersCounter.call(2)).to eq(100)
    end

    it 'returns 475 for power 3' do
      expect(IncreasingDecreasingNumbersCounter.call(3)).to eq(475)
    end

    it 'returns 1675 for power 4' do
      expect(IncreasingDecreasingNumbersCounter.call(4)).to eq(1675)
    end

    it 'returns 4954 for power 5' do
      expect(IncreasingDecreasingNumbersCounter.call(5)).to eq(4954)
    end

    it 'returns 12952 for power 6' do
      expect(IncreasingDecreasingNumbersCounter.call(6)).to eq(12952)
    end

    it 'handles larger powers efficiently' do
      expect(IncreasingDecreasingNumbersCounter.call(7)).to be > 0 # Just check it returns a value within reasonable time
    end
  end
end
