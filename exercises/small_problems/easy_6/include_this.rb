def include?(array, search)
  return false if array.empty?
  new_array = array.select {|num| num == search }
  new_array[0] == search
end

p include?([1,2,3,4,5], 3) == true
p include?([1,2,3,4,5], 6) == false
p include?([], 3) == false
p include?([nil], nil) == true
p include?([], nil) == false
