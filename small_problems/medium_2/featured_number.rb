def featured(num)
  initial_num = num
  array = []
  loop do
    array = num.digits
    break if featured_num_checks?(num, initial_num)
    if array.count >= 10 && num >= 9999999999
      puts "There is no possible number that fulfills those requirements."
      break
    end
    num += 1
  end
  num
end

def featured_num_checks?(num, i_num)
  single_digits?(num) && num.odd? && num % 7 == 0 && i_num != num
end

def single_digits?(num)
  array = num.digits
  !array.any? { |number| array.count(number) > 1 }
end


p featured(12) == 21
p featured(20) == 21
p featured(21) == 35
p featured(997) == 1029
p featured(1029) == 1043
p featured(999_999) == 1_023_547
p featured(999_999_987) == 1_023_456_987
#
p featured(9_999_999_999) # -> There is no possible number that fulfills those requirements
