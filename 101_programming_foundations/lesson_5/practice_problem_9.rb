arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

new_arr = arr.map do |array|
  array.sort { |a, b| b <=> a }
end
p new_arr
