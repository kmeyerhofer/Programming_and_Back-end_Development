def double_consonants(string)
  array = string.chars.map do |letter|
    if letter.match(/[[:alpha:]&& [^a,e,i,o,u]]/)
      letter * 2
    else
      letter
    end
  end
  array.join
end

p double_consonants('String') == "SSttrrinngg"
p double_consonants("Hello-World!") == "HHellllo-WWorrlldd!"
p double_consonants("July 4th") == "JJullyy 4tthh"
p double_consonants('') == ""
