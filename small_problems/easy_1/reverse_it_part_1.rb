def reverse_sentence(sentence)
  sentence_array = sentence.split
  sentence_array_reversed = sentence_array.reverse
  sentence_array_reversed.join(' ')
end

# solution is much cleaner: sentence.split.reverse.join(' ')

puts reverse_sentence('') == ''
puts reverse_sentence('Hello World') == 'World Hello'
puts reverse_sentence('Reverse these words') == 'words these Reverse'
