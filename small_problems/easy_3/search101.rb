def prompt(message)
  puts "==> #{message}"
end

def return_num(num)
  prompt("Enter the #{num} number:")
  gets.chomp.to_i
end

one = return_num("1st")
two = return_num("2nd")
three = return_num("3rd")
four = return_num("4th")
five = return_num("5th")
six = return_num("last")

numbers = [one, two, three, four, five]

if numbers.include?(six)
  prompt("The number #{six} appears in #{numbers}.")
else
  prompt("The number #{six} does not appear in #{numbers}.")
end
