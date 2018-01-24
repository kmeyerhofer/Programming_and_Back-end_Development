def reverse(array)
  l_index = 0
  r_index = -1
  new_array = []

  while l_index < array.size
    new_array.insert(l_index, array[r_index])
    l_index += 1
    r_index -= 1
  end
  new_array
end

# array[left_index], array[right_index] = array[right_index], array[left_index]
# useful parallel assignment

p reverse([1,2,3,4]) == [4,3,2,1]          # => true
p reverse(%w(a b c d e)) == %w(e d c b a)  # => true
p reverse(['abc']) == ['abc']              # => true
p reverse([]) == []                        # => true

p list = [1, 2, 3]                      # => [1, 2, 3]
p new_list = reverse(list)              # => [3, 2, 1]
p list.object_id != new_list.object_id  # => true
p list == [1, 2, 3]                     # => true
p new_list == [3, 2, 1]                 # => true
