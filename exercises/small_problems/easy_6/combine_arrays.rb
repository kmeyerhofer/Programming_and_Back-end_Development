def merge(array1, array2)
  new_array = []
  array1.each { |num| new_array << num unless new_array.include?(num) }
  array2.each { |num| new_array << num unless new_array.include?(num) }
  new_array
end

p merge([1, 3, 5], [3, 6, 9]) == [1, 3, 5, 6, 9]
