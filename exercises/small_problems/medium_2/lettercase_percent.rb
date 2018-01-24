def letter_percentages(string)
  hash = Hash.new(0)
  total_length = string.length.to_f
  hash[:lowercase] = (string.count("a-z") / total_length * 100.0)
  hash[:uppercase] = (string.count("A-Z") / total_length * 100.0)
  hash[:neither] = (string.count("\^a-zA-Z") / total_length * 100.0)
  p hash
end

p letter_percentages('abCdef 123') == { lowercase: 50, uppercase: 10, neither: 40 }
p letter_percentages('AbCd +Ef') == { lowercase: 37.5, uppercase: 37.5, neither: 25 }
p letter_percentages('123') == { lowercase: 0, uppercase: 0, neither: 100 }
