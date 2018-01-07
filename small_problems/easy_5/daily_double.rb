def crunch(sentence)
  new_sentence = sentence.split.map do |word|
    counter = 0
    new_word = word.split('')
    loop do
    if new_word[0] == new_word[1]
      new_word.delete_at(0)
      counter += 1
    elsif new_word[counter] == new_word[counter + 1]
      new_word.delete_at(counter)
      counter += 1
    else
      counter += 1
    end
    break if counter == word.length
    end
    new_word.join('')
  end
  new_sentence.join(' ')
end

p crunch('ddaaiillyy ddoouubbllee') == 'daily double'
p crunch('4444abcabccba') == '4abcabcba'
p crunch('ggggggggggggggg') == 'g'
p crunch('a') == 'a'
p crunch('') == ''
