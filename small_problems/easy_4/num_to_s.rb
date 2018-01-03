def integer_to_string(num)
  num_array = num.digits.reverse
  num_array.map do |digit|
    int_hash(digit)
  end
  num_array.join
end

def int_hash(key)
  {
    [0] => '0', [1] => '1', [2] => '2', [3] => '3', [4] => '4',
    [5] => '5', [6] => '6', [7] => '7', [8] => '8', [9] => '9'
  }.fetch(key, 'No digit')
end

p integer_to_string(4321)
p integer_to_string(0)
p integer_to_string(5000)
