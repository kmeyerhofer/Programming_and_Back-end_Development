def palindromic_number?(num)
  pnum = num.to_s.split('')
  pnum.reverse == pnum
end

p palindromic_number?(34543) == true
p palindromic_number?(123210) == false
p palindromic_number?(22) == true
p palindromic_number?(00500) == true
