def string_to_integer(string)
  negative_one = strip_sign(string)
  array = string.split('').map {|num| int_hash(num.bytes)}
  number = 0
  array_count = array.count
  array.map do |num| # map_with_index
    number += (num * (10 ** (array_count - 1)))
    array_count -= 1
  end
  negative_one.odd? ? number * negative_one : number
end

def strip_sign(string)
  sign = ''
  if string.start_with?('-')
    negative_sign = string.slice!(0)
    -1
  elsif string.start_with?('+')
    positive_sign = string.slice!(0)
    0
  else
    0
  end
end

def int_hash(key)
  {
    [48] => 0, [49] => 1, [50] => 2, [51] => 3, [52] => 4,
    [53] => 5, [54] => 6, [55] => 7, [56] => 8, [57] => 9#,
    #[45] => -
  }.fetch(key)
end

p string_to_integer('4321') == 4321
p string_to_integer('-570') == -570
p string_to_integer('+100') == 100
