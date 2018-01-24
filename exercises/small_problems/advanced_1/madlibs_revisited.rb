def madlibs(file)
  puts """
  The #{ADJECTIVES.sample} #{ADJECTIVES.sample} #{NOUNS.sample} #{ADVERBS.sample}
  #{VERBS.sample} the #{ADJECTIVES.sample} #{ADJECTIVES.sample} #{NOUNS.sample}, who #{ADVERBS.sample}
  #{VERBS.sample} the #{NOUNS.sample} and #{VERBS.sample} around.
  """
end

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

file = File.new("madlibs.txt", "r+")

ADJECTIVES = file_to_hash(file)['adjectives'].freeze
ADVERBS = file_to_hash(file)['adverbs'].freeze
NOUNS = file_to_hash(file)['nouns'].freeze
VERBS = file_to_hash(file)['verbs'].freeze

madlibs(file)
