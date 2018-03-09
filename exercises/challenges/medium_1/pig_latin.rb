class PigLatin
  def self.translate(word)
    word[0].match?(/[aeiou]/) ? self.vowel(word) : self.consonant(word)
  end

  def self.vowel(word)
    word.split('').push('ay').join
  end

  def self.consonant(word)
    if word.count(' ') > 0
      word_array = []
      word.split(' ').each do |wd|
        word_array << self.consonant_exceptions(wd).push('ay').join
      end
      word_array.join(' ')
    else
      self.consonant_exceptions(word).push('ay').join
    end
  end

  def self.consonant_exceptions(word)
    if word.match?(/(\b[^aeiou]qu.)|(\bthr.)|(\bsch.)/)
      self.split_and_rotate(word, 3)
    elsif word.match?(/(\bch.)|(\bth.)|(\bqu.)/)
      self.split_and_rotate(word, 2)
    elsif word.match?(/(\byt.)|(\bxr.)/)
      self.split_and_rotate(word, 0)
    else
      self.split_and_rotate(word, 1)
    end
  end

  def self.split_and_rotate(word, num)
    word.split('').rotate(num)
  end
end
