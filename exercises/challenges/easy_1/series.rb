class Series
  attr_reader :number
  def initialize(string_num)
    @number = string_num.split('').map(&:to_i)
  end

  def slices(digits)
    raise ArgumentError if digits > number.size
    returned_array = []
    num_series(number, digits) { |num| returned_array << num }
    returned_array
  end

  def num_series(num_array, digits)
    index = 0
    while index < num_array.size - digits + 1
      yield(num_array[index..(index + digits - 1)])
      index += 1
    end
  end
end
