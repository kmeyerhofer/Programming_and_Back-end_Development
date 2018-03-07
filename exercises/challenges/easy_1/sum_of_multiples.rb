class SumOfMultiples
  attr_accessor :multiples
  def initialize(*multiples)
    @multiples = multiples
  end

  def to(max_num)
    calculate_sum(max_num, multiples)
  end

  def calculate_sum(max_num, array)
    sum_array = []
    array.each do |multiple_num|
      0.upto(max_num - 1) do |num|
        sum_array << num if !sum_array.include?(num) && num % multiple_num == 0
      end
    end
    sum_array.empty? ? 0 : sum_array.inject(:+)
  end

  def self.to(max_num)
    new(3, 5).to(max_num)
  end
end
