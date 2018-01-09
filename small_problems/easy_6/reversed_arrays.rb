def reverse!(array)
  length = array.length - 1
  length.times do |num|
    array.insert(num, array.pop)
  end
  array
end

# array[left_index], array[right_index] = array[right_index], array[left_index]
# useful parallel assignment

p list = [1,2,3,4]
p result = reverse!(list) # => [4,3,2,1]
p list == [4, 3, 2, 1]
p list.object_id == result.object_id

p list = %w(a b c d e)
p reverse!(list) # => ["e", "d", "c", "b", "a"]
p list == ["e", "d", "c", "b", "a"]

p list = ['abc']
p reverse!(list) # => ["abc"]
p list == ["abc"]

p list = []
p reverse!(list) # => []
p list == []
