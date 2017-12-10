arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3], [1, 6, 5], [1, 2, 11]]


arr.sort do |a, b|
  c = a.select {|array1| array1.odd?}
  d = b.select {|array2| array2.odd?}
  c <=> d
end
