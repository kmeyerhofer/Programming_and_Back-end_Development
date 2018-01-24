def ascii_value(string)
  return 0 if string.empty?
  characters = string.split('')
  values = characters.map {|letter| letter.ord }
  values.inject(:+)
end

p ascii_value('Four score') == 984
p ascii_value('Launch School') == 1251
p ascii_value('a') == 97
p ascii_value('') == 0
