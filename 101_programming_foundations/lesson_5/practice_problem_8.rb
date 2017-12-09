require 'pry'
hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

hsh.each do |hashes|
  hashes[1].each do |words|
    words.scan(/[aeiou]/) {|x| puts x}
  end
end
