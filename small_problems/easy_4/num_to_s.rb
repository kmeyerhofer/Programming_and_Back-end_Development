def integer_to_string(num)
  num_array = num.digits.reverse
  num_array.map do |digit|
    int_hash(digit)
  end
  num_array
end

def int_hash(key)
  {
    [0] => '0', [1] => '1', [2] => '2', [3] => '3', [4] => '4',
    [5] => '5', [6] => '6', [7] => '7', [8] => '8', [9] => '9'
  }.fetch(key, 'No digit')
end

def signed_integer_to_string(num)
  if num > 0
    integer_to_string(num).unshift("+").join
  elsif num < 0
    abs_num = num.abs
    integer_to_string(abs_num).unshift("-").join
  else
    integer_to_string(num).join
  end
end

p signed_integer_to_string(4321)
p signed_integer_to_string(0)
p signed_integer_to_string(5000)
p signed_integer_to_string(-123)
