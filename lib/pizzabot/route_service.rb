require_relative 'grid_error'
require_relative 'address_error'

class RouteService
  GRID_REGEX = /^\s*\d+x\d+/
  ADDRESSES_REGEX = /\((.*?)\)/
  DIGITS_EXTRACT_REGEX = /\d+/

  NEGATIVE_NUMBERS_MESSAGE = 'Address should not have negative numbers'
  NOT_IN_RANGE_MESSAGE = 'Address is not in delivery range'

  attr_reader :grid
  attr_accessor :addresses

  def initialize(delivery_string)
    @grid = delivery_string[GRID_REGEX]&.split('x')&.map(&:to_i)
    @addresses = delivery_string.scan(ADDRESSES_REGEX).flatten
  end

  def prepare_route
    validate_route
    calculate_route
  end

  private

  def validate_route
    raise GridError unless grid

    addresses.map! do |address|
      raise AddressError, NEGATIVE_NUMBERS_MESSAGE if address.include?('-')

      extracted_array = address.scan(DIGITS_EXTRACT_REGEX).map(&:to_i)
      raise AddressError, "Wrong format address: #{address}" unless extracted_array.length == 2
      raise AddressError, NOT_IN_RANGE_MESSAGE if extracted_array[0] > grid[0] ||
                                                  extracted_array[1] > grid[1]

      extracted_array
    end
  end

  def calculate_route
    addresses.sort.uniq
  end
end
