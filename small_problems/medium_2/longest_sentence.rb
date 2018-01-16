def longest_sentence(text_file)
  word_count = 0
  sentence_lengths = []
  text_string = File.read(text_file)
  text_file_string = text_string.tr("\n", " ").split
  text_file_string.each do |word|
    word.split(' ').count
    if word.end_with?('.', '?', '!')
      sentence_lengths << word_count + 1
      word_count = 0
    else
      word_count += 1
    end
  end
  sentence_lengths.max
end


example = File.new("example.txt", "r+")
longest_sentence(example)

frankenstein = File.new("frankenstein.txt", "r")
longest_sentence(frankenstein)
