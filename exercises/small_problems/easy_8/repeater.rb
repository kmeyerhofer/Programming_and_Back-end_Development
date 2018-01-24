def repeater(string)
  array = string.chars
  array.map { |letter| letter * 2}.join
end

p repeater('Hello') == "HHeelllloo"
p repeater("Good job!") == "GGoooodd  jjoobb!!"
p repeater('') == ''
