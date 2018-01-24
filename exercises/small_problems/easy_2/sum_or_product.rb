def prompt(message)
  puts ">> #{message}"
end

def sum(num)
  if num > 0
    num + sum(num - 1)
  else
    num
  end
end

def product(num)
  if num > 0
    num * product(num - 1)
  else
    1
  end
end

loop do
  prompt("Please enter an integer greater than 0:")
  number = gets.chomp.to_i
  if number < 1
    prompt("Please enter a valid number.")
  else
    loop do
      prompt("Enter 's' to compute the sum. 'p' to compute the product:")
      computation = gets.chomp
      case computation
      when 's'
        prompt("The sum of the integers between 1 and #{number} is #{sum(number)}.")
        break
      when 'p'
        prompt("The product of the integers between 1 and #{number} is #{product(number)}.")
        break
      when 'q'
        break
      else
        prompt("Please enter a valid choce.")
      end
    end
  end
  prompt("Would you like to enter another number? 'n' to quit")
  selection = gets.chomp
  break if selection.downcase == 'n'
end
