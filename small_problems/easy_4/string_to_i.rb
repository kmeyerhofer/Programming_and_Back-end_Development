def string_to_integer(string)
  array = string.split('').map {|num| int_hash(num.bytes)}
  number = 0
  array_count = array.count
  array.map do |num| # map_with_index
    number += (num * (10 ** (array_count - 1)))
    array_count -= 1
  end
  number
end

def int_hash(key)
  {
    [48] => 0, [49] => 1, [50] => 2, [51] => 3, [52] => 4,
    [53] => 5, [54] => 6, [55] => 7, [56] => 8, [57] => 9
  }.fetch(key)
end

p string_to_integer('4321') == 4321
p string_to_integer('570') == 570
p string_to_integer('8372939') == 8372939
