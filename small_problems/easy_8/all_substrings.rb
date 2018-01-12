def substrings_at_start(string)
  new_array = []
  index = 0
  loop do
    new_array.push(string[0, index+1])
    index += 1
    break if index == string.length
  end
  new_array
end

def substrings(string)
  new_string = string.chars
  index = 0
  all_substrings = []
  loop do
    all_substrings += substrings_at_start(new_string[index..(string.length)])
    index +=1
    break if index == string.length
  end
  p all_substrings.map(& :join)
end

p substrings('abcde') == [
  'a', 'ab', 'abc', 'abcd', 'abcde',
  'b', 'bc', 'bcd', 'bcde',
  'c', 'cd', 'cde',
  'd', 'de',
  'e'
]
