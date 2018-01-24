def average(array)
  average = array.inject {|sum, num| sum + num} / (array.count)
  average.to_f
end

puts average([1, 5, 87, 45, 8, 8]) == 25.0
puts average([9, 47, 23, 95, 16, 52]) == 40.0
