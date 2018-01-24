def digit_list(num)
  string_num = num.to_s
  arr = string_num.split('')
  arr.map! do |numbers|
    numbers.to_i
  end
  arr
end

puts digit_list(12345) == [1, 2, 3, 4, 5]     # => true
puts digit_list(7) == [7]                     # => true
puts digit_list(375290) == [3, 7, 5, 2, 9, 0] # => true
puts digit_list(444) == [4, 4, 4]             # => true
