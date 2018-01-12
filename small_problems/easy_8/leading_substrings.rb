def substrings_at_start(string)
  new_array = []
  index = 0
  loop do
    new_array << string[0, index+1]
    index += 1
    break if index == string.length
  end
  new_array
end

p substrings_at_start('abc') == ['a', 'ab', 'abc']
p substrings_at_start('a') == ['a']
p substrings_at_start('xyzzy') == ['x', 'xy', 'xyz', 'xyzz', 'xyzzy']
