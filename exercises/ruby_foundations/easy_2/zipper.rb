def zip(first_array, second_array)
  index = 0
  zipped_array = []
  while index < first_array.size
    temp = []
    temp << first_array[index]
    temp << second_array[index]
    zipped_array << temp
    index += 1
  end
  zipped_array
end

p zip([1, 2, 3], [4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]
