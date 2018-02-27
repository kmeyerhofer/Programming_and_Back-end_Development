def max_by(array)
  return nil if array.empty?
  index = 1
  largest_element = yield(array.first)
  largest_index = 0
  while index < array.size
    if yield(array[index]) > largest_element
      largest_element = yield(array[index])
      largest_index = index
    end
    index += 1
  end
  array[largest_index]
end

p max_by([1, 5, 3]) { |value| value + 2 } == 5
p max_by([1, 5, 3]) { |value| 9 - value } == 1
p max_by([1, 5, 3]) { |value| (96 - value).chr } == 1
p max_by([[1, 2], [3, 4, 5], [6]]) { |value| value.size } == [3, 4, 5]
p max_by([-7]) { |value| value * 3 } == -7
p max_by([]) { |value| value + 5 } == nil
