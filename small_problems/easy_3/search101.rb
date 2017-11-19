def prompt(message)
  puts "==> #{message}"
end

def get_num(num)
  prompt("Enter the #{num} number:")
  gets.chomp.to_i
end

loop do
  one = get_num("1st")
  two = get_num("2nd")
  three = get_num("3rd")
  four = get_num("4th")
  five = get_num("5th")
  six = get_num("last")

  arr = [one, two, three, four, five]
  arr2 = arr.select do |num|
    num - six >= 0
  end

  if arr2.count > 0
    prompt("The number #{six} appears in #{arr2}.")
  else
    prompt("The number #{six} does not appear in #{arr}.")
  end
  break
end
