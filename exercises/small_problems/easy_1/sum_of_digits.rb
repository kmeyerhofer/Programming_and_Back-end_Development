def sum(num)
  num_array_s = num.to_s.split('')
  num_array_i = num_array_s.map! {|num| num.to_i}
  num_array_i.inject {|sum, num| sum + num}
  # number.to_s.chars.map(&:to_i).reduce(:+) L.S. Answer
end

puts sum(23) == 5
puts sum(496) == 19
puts sum(123_456_789) == 45
