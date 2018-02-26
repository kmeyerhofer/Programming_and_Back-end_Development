def max_by(array)
  return nil if array.empty?
  index = 0
  largest_element = array.first
  previous_value = yield(array[index])
  while index < array.size
    largest_element =  if yield(array[index]) > previous_value
    index += 1
  end
  largest_element
end

p max_by([1, 5, 3]) { |value| value + 2 } == 5
p max_by([1, 5, 3]) { |value| 9 - value } == 1
p max_by([1, 5, 3]) { |value| (96 - value).chr } == 1
p max_by([[1, 2], [3, 4, 5], [6]]) { |value| value.size } == [3, 4, 5]
p max_by([-7]) { |value| value * 3 } == -7
p max_by([]) { |value| value + 5 } == nil
