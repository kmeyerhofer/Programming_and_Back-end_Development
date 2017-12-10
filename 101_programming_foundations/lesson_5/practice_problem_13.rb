require 'pry'
arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3], [1, 6, 5], [1, 2, 11]]


newa = arr.sort do |a, b|
  c = a.select {|array1| array1.odd?}
  d = b.select {|array2| array2.odd?}
  c <=> d


  # counter = 0
  # sort_value = 0
  # loop do
  #   binding.pry
  #   sort_value = a[counter] <=> b[counter] if a[counter].odd? && b[counter].odd?
  #   counter += 1
  #   sort_value if counter == a.count #break
  #   break if counter == a.count

  # end
  #binding.pry
  # a.sort do |b, c|
  #   binding.pry
  #   b.odd? && c.odd? ? b.to_i <=> c.to_i : next
  # end
  # d.sort do |e, f|
  # # sub_arr.sort do |a, b|
  # #   binding.pry
  #    e.odd? && f.odd? ? e.to_i <=> f.to_i : next
  #  end
  # # end
end

p newa
