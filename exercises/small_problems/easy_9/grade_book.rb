def get_grade(test_one, test_two, test_three)
  average = (test_one + test_two + test_three) / 3
  if average >= 90
    'A'
  elsif average >= 80 && average < 90
    'B'
  elsif average >= 70 && average < 80
    'C'
  elsif average >= 60 && average < 70
    'D'
  elsif average < 60
    'F'
  end
end

p get_grade(95, 90, 93) == "A"
p get_grade(50, 50, 95) == "D"
