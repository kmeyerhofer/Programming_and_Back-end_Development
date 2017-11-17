def prompt(text)
  puts "=> #{text}"
end

prompt("What is your name?")
name = gets.chomp

if name.end_with?("!")
  prompt("HELLO #{name.upcase}. WHY ARE WE SCREAMING?")
else
  prompt("Hello #{name}.")
end
