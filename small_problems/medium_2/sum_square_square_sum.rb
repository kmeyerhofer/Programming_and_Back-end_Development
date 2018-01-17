def sum_square_difference(num)
  int = 0
  1.upto(num) { |sum| int += sum }
  squared_sum = int ** 2
  
  numbers = 0
  1.upto(num) { |nums| numbers += nums ** 2 }

  squared_sum - numbers
end

p sum_square_difference(3) == 22
   # -> (1 + 2 + 3)**2 - (1**2 + 2**2 + 3**2)
p sum_square_difference(10) == 2640
p sum_square_difference(1) == 0
p sum_square_difference(100) == 25164150
