def is_odd?(num)
  num.remainder(2) == 1 || num.remainder(2) == -1 # % 2 == 0 ? false : true
end

puts is_odd?(2)
puts is_odd?(5)
puts is_odd?(-17)
puts is_odd?(-8)
puts is_odd?(0)
puts is_odd?(7)
