def interleave(array_one, array_two)
  joined_array = []
  index = 0
  loop do
    joined_array << array_one[index]
    joined_array << array_two[index]
    index += 1
    break if index == array_one.count
  end
  p joined_array
end

p interleave([1, 2, 3], ['a', 'b', 'c']) == [1, 'a', 2, 'b', 3, 'c']
