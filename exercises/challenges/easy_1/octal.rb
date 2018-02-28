require 'pry'
class Octal
  attr_reader :value
  def initialize(value)
    @value = check_validity(value)
  end

  def to_decimal
    return value if value == 0
    length = value.size
    index = 0
    integer_array = value.map do |num|
      index += 1
      num.to_i * (8**(length - index))
    end
    integer_array.inject(:+)
  end

  def check_validity(value)
    if value.match?(/['8-9', a-z]/i)
      0
    else
      value.split('')
    end
  end
end
