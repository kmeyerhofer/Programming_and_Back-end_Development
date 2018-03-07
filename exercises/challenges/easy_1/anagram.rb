require 'pry'

class Anagram
  attr_reader :all_word_anagrams
  def initialize(word)
    @word = word.downcase
  end

  def match(words)
    words.select { |word| anagrams?(word) }
  end

  def anagrams?(word)
    word.downcase != @word &&
    word.downcase.chars.sort == @word.chars.sort
  end
end
