def multisum(num)
  (1..num).select { |number| (number % 3 == 0 || number % 5 == 0) }.inject(:+)
end

p multisum(3) == 3
p multisum(5) == 8
p multisum(10) == 33
p multisum(1000) == 234168
