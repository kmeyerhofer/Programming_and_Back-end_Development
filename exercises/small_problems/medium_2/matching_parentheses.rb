def balanced?(string)
  parentheses = 0
  string.each_char do |char|
    parentheses += 1 if char == '('
    parentheses -= 1 if char == ')'
    break if parentheses < 0
  end
  parentheses.zero?
end

p balanced?('What (is) this?') == true
p balanced?('What is) this?') == false
p balanced?('What (is this?') == false
p balanced?('((What) (is this))?') == true
p balanced?('((What)) (is this))?') == false
p balanced?('Hey!') == true
p balanced?(')Hey!(') == false
p balanced?('What ((is))) up(') == false
