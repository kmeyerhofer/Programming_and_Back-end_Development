BLOCKS = {
  'B' => 'O',   'X' => 'K',   'D' => 'Q',   'C' => 'P',   'N' => 'A',
'G' => 'T',   'R' => 'E',   'F' => 'S',   'J' => 'W',   'H' => 'U',
'V' => 'I',   'L' => 'Y',   'Z' => 'M'
}.freeze

def block_word?(word)
  used_letter = []
  word.split('').all? do |letter|
    return false if used_letter.flatten.include?(letter)
    if BLOCKS.key?(letter.upcase)
      used_letter.push(BLOCKS[letter.upcase])
      used_letter.push(letter.upcase)
    else
      used_letter.push(BLOCKS.rassoc(letter.upcase))
    end
  end
end

p block_word?('BATCH') == true
p block_word?('BUTCH') == false
p block_word?('jest') == true
