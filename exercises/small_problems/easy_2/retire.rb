current_year = Time.now.year

puts 'What is your age?'
age = gets.chomp.to_i
puts 'At what age would you like to retire?'
retirement_age = gets.chomp.to_i

work_years = retirement_age - age
retirement_year = current_year + work_years

puts "It's #{current_year}. You will retire in #{retirement_year}."
puts "You only have #{work_years} years of work to go!"
