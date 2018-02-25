def each_number(array)
  counter = 0
  expected_num = array[counter]
  while expected_num != array[-1]
    expected_num += 1
    yield(expected_num) if !array.include?(expected_num)
  end
end

def missing(array)
  missing_array = []
  each_number(array) { |num| missing_array << num }
  missing_array
end


p missing([-3, -2, 1, 5]) == [-1, 0, 2, 3, 4]
p missing([1, 2, 3, 4]) == []
p missing([1, 5]) == [2, 3, 4]
p missing([6]) == []
