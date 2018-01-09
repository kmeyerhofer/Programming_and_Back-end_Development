def halvsies(array)
  half_limit = array.count.odd? ? (array.count/2) + 1 : array.count/2
  first = []
  half_limit.times {|_| first << array.shift}
  [first, array]
end

p halvsies([1, 2, 3, 4]) == [[1, 2], [3, 4]]
p halvsies([1, 5, 2, 4, 3]) == [[1, 5, 2], [4, 3]]
p halvsies([5]) == [[5], []]
p halvsies([]) == [[], []]
