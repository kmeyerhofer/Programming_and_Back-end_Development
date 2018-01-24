
# input: 2 boolean values, returns true if exactly one is truthy, false
# if otherwise


def xor?(one, two)
 !(one && two) && (one || two)
end



p xor?(5.even?, 4.even?) == true
p xor?(5.odd?, 4.odd?) == true
p xor?(5.odd?, 4.even?) == false
p xor?(5.even?, 4.odd?) == false
