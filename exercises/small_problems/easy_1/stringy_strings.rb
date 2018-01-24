def stringy(num, counter = 1)
  array = []
  num.times do
    if counter == 1
      array << '1'
      counter -= 1
    elsif counter == 0
      array << '0'
      counter += 1
    end
  end
  array.join
end

puts stringy(6) == '101010'
puts stringy(9) == '101010101'
puts stringy(4) == '1010'
puts stringy(7) == '1010101'

puts stringy(17, 0) == '01010101010101010'
puts stringy(5, 0) == '01010'
puts stringy(8, 0) == '01010101'
puts stringy(10, 0) == '0101010101'
