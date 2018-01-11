def swapcase(string)
  new_string = string.chars.map do |letter|
    if letter.match?(/[a-z]/)
      letter.upcase
    elsif letter.match?(/[A-Z]/)
      letter.downcase
    else
      letter
    end
  end
  p new_string.join
end

p swapcase('CamelCase') == 'cAMELcASE'
p swapcase('Tonight on XYZ-TV') == 'tONIGHT ON xyz-tv'
