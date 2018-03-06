require 'pry'

class Trinary
  attr_reader :value, :split_value
  def initialize(value)
    @value = value
    @split_value = value.split('')
  end

  def invalid?
    value.match?(/[^012]+/)
  end

  def to_decimal
    return 0 if invalid?
    num_index = -1
    power_index = 0
    decimal_array = []
    while power_index < split_value.size
      decimal_array << (split_value[num_index].to_i * (3 ** power_index))
      num_index -= 1
      power_index += 1
    end
    decimal_array.reduce(:+)
  end
end
