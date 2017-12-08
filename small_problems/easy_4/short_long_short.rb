def short_long_short(string1, string2)
  (string1.length > string2.length) ? concatenator(string2, string1) : concatenator(string1, string2)
end

def concatenator(short, long)
  "#{short}#{long}#{short}"
end

p short_long_short('abc', 'defgh') == "abcdefghabc"
p short_long_short('abcde', 'fgh') == "fghabcdefgh"
p short_long_short('', 'xyz') == "xyz"
