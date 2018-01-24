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
  all_substrings.map(& :join)
end

def palindromes(string)
  all_substrings = substrings(string)
  palindromes = all_substrings.select do |strings|
    strings == strings.reverse if strings.length != 1
  end
  palindromes
end

p palindromes('abcd') == []
p palindromes('madam') == ['madam', 'ada']
p palindromes('hello-madam-did-madam-goodbye') == [
  'll', '-madam-', '-madam-did-madam-', 'madam', 'madam-did-madam', 'ada',
  'adam-did-mada', 'dam-did-mad', 'am-did-ma', 'm-did-m', '-did-', 'did',
  '-madam-', 'madam', 'ada', 'oo'
]
p palindromes('knitting cassettes') == [
  'nittin', 'itti', 'tt', 'ss', 'settes', 'ette', 'tt'
]
