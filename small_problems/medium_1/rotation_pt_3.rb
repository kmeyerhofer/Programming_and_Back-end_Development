def rotate_array(array)
  array[1..-1] + [array[0]]
end

def rotate_rightmost_digits(num, r_digits)
  num_array = num.digits.reverse
  (num_array[0..-r_digits-1] + rotate_array(num_array[-r_digits..-1])).join.to_i
end

def max_rotation(num)
  num_length = num.digits.count
  num_length.downto(2) do |n|
    num = rotate_rightmost_digits(num, n)
  end
  num
end

p max_rotation(735291) == 321579
p max_rotation(3) == 3
p max_rotation(35) == 53
p max_rotation(105) == 15 # the leading zero gets dropped
p max_rotation(8_703_529_146) == 7_321_609_845
