def multiply_list(array_one, array_two)
  new_array = []
  array_one.count.times {|num| new_array << (array_one[num] * array_two[num])}
  new_array
end

p multiply_list([3, 5, 7], [9, 10, 11]) == [27, 50, 77]
