# Refactored
# def xor?(bool1, bool2)
#   if bool1 && bool2
#     false
#   elsif bool1 || bool2
#     true
#   else
#     false
#   end
# end

def xor?(value1, value2)
  (value1 && !value2) || (value2 && !value1)
end

xor?(5.even?, 4.even?) == true
xor?(5.odd?, 4.odd?) == true
xor?(5.odd?, 4.even?) == false
xor?(5.even?, 4.odd?) == false
