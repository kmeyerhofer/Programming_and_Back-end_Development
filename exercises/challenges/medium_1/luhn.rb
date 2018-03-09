require 'pry'
class Luhn
  attr_accessor :num
  def initialize(num)
    @num = num.digits
  end

  def checksum
    addends.inject(&:+)
  end

  def valid?
    checksum % 10 == 0
  end

  def self.create(number)
    new_luhn = new(number)
    (0..9).find do |int|
      new_luhn.num = number.digits
      new_luhn.num.unshift(int)
      new_luhn.valid?
    end
    new_luhn.number_from_array
  end

  def number_from_array
    num.reverse.join.to_i
  end

  def addends
    every_other(num) do |number|
      double = number * 2
      double > 10 ? double - 9 : double
    end.reverse
  end

  def every_other(array)
    index = 0
    digits = []
    while index < array.count
      index.odd? ? digits << yield(array[index]) : digits << array[index]
      index += 1
    end
    digits
  end
end
