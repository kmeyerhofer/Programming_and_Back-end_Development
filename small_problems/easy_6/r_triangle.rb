def triangle(sides)
  array = []
  sides.times { |num| array.push("#{' '*((sides-1)-num)}#{'*'*(num+1)}") }
  sides.times { |index| puts array[index]}
end

triangle(6)
