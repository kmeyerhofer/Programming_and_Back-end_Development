# characters = gets.chomp.join('').chars
puts "Please write word or multiple words:"
user_input = gets.chomp

counted_input = user_input.delete(' ').size

puts "There are #{counted_input} characters in '#{user_input}'."
