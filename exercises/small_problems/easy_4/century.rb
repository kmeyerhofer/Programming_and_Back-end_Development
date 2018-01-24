def century(year)
  by_100 = year / 100
  by_100_plus_1 = by_100 + 1

  if year % 100 > 0
    string_year = by_100_plus_1.to_s
    last_num = string_year.chars.pop
    last_two_num = string_year.chars.pop(2).join
    endings(last_two_num) ? century_string(by_100_plus_1, last_two_num) : century_string(by_100_plus_1, last_num)
  elsif year % 100 == 0
    string_year = by_100.to_s
    last_num = string_year.chars.pop
    century_string(by_100, last_num)
  end
end

def century_string(century, ending)
  "#{century}" + endings(ending)
end

def endings(key)
  {
  '1' => 'st', '2' => 'nd', '3' => 'rd', '4' => 'th', '5' => 'th',
  '6' => 'th', '7' => 'th', '8' => 'th', '9' => 'th', '0' => 'th',
  '11' => 'th', '12' => 'th', '13' => 'th'
}.fetch(key, false)
end


p century(2000) == '20th'
p century(2001) == '21st'
p century(1965) == '20th'
p century(256) == '3rd'
p century(5) == '1st'
p century(10103) == '102nd'
p century(1052) == '11th'
p century(1127) == '12th'
p century(11201) == '113th'
p century(144221112) == '1442212th'
