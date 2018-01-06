def swap(sentence)
  new_sentence = sentence.split(' ').map do |word|
    end_letter = word.slice!(-1)
    beginning_letter = word.slice!(0)
    "#{end_letter}#{word}#{beginning_letter}"
  end
  new_sentence.join(' ')
end


p swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
p swap('Abcde') == 'ebcdA'
p swap('a') == 'a'
