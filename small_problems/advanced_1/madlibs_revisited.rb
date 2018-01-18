def madlibs(file)
  madlib_data = file_to_hash(file)
  puts """
  The #{random_value('adjective', madlib_data)} #{random_value('adjective', madlib_data)} #{random_value('noun', madlib_data)} #{random_value('adverb', madlib_data)}
  #{random_value('verb', madlib_data)} the #{random_value('adjective', madlib_data)} #{random_value('adjective', madlib_data)} #{random_value('noun', madlib_data)}, who #{random_value('adverb', madlib_data)}
  #{random_value('verb', madlib_data)} the #{random_value('noun', madlib_data)} and #{random_value('verb', madlib_data)} around.
  """

end
require 'pry'
def file_to_hash(file)
  words = File.read(file)
  split_words = words.split("\n")
  index = 0
  madlib_hash = Hash.new('')
  loop do
    madlib_hash[split_words[index]] = split_words[index + 1].split
    index += 2
    break if index >= 8
  end
  madlib_hash
end

def random_value(word_type, hash)
  #binding.pry
  hash[word_type].sample
end


file = File.new("madlibs.txt", "r+")
madlibs(file)
