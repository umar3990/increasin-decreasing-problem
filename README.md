# Increasing and Decreasing Numbers Calculator

This Rails application calculates the total occurrences of increasing and decreasing numbers up to a given power of 10.

**Increasing Numbers:**
* Digits increase from left to right (e.g., 123, 4567)

**Decreasing Numbers:**
* Digits decrease from left to right (e.g., 987, 6543)

## Features

* **Efficient Calculation:** Implements an optimized algorithm to efficiently calculate the number of increasing and decreasing numbers.
* **Robust Testing:** Comprehensive test suite using RSpec to ensure the accuracy and reliability of the calculations.

## Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/abdullah5514/inc_dec_calculator.git
   cd inc_dec_calculator
   ```

2. **Install Dependencies:**

   ```bash
   bundle install
   ```

3. **Setup Database:**

   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Running Test to verify the problem solution:**

   ```bash
   rspec
   ```

## Usage

The core logic for calculating the number of increasing and decreasing numbers resides in the app/services/increasing_decreasing_numbers_counter.rb file.

**Example Usage:**

You can interact with this service directly in the Rails console.

   ```bash
    rails c
    # In Rails console:
    > IncreasingDecreasingNumbersCounter.call(0)  # => 1
    > IncreasingDecreasingNumbersCounter.call(1)  # => 10
    > IncreasingDecreasingNumbersCounter.call(2)  # => 100
    > IncreasingDecreasingNumbersCounter.call(3)  # => 475
   ```