def twice(num)
  num_digits = num.digits
  digit_count = num.digits.count
  if digit_count.odd?
    num * 2
  elsif num_digits[0, digit_count/2] == num_digits[digit_count/2, digit_count]
    num
  else
    num * 2
  end
end

p twice(37) == 74
p twice(44) == 44
p twice(334433) == 668866
p twice(444) == 888
p twice(107) == 214
p twice(103103) == 103103
p twice(3333) == 3333
p twice(7676) == 7676
p twice(123_456_789_123_456_789) == 123_456_789_123_456_789
p twice(5) == 10
