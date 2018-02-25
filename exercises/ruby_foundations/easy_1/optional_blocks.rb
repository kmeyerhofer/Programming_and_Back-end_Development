def compute(argument)
  block_given? ? yield(argument) : 'Does not compute.'
end

puts compute(3) { 5 + 3 } == 8
p compute(2) { 'a' + 'b' } == 'ab'
p compute == 'Does not compute.'
