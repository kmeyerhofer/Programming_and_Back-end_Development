def find_fibonacci_index_by_length(length)
  next_num = 0
  index = 0
  num1 = 1
  num2 = 1
  while next_num.digits.count < length
    num1 = num2
    num2 = next_num
    next_num = num1 + num2
    index += 1
  end
  index
end

p find_fibonacci_index_by_length(2) == 7
p find_fibonacci_index_by_length(10) == 45
p find_fibonacci_index_by_length(100) == 476
p find_fibonacci_index_by_length(1000) == 4782
p find_fibonacci_index_by_length(10000) == 47847
