def prompt(message)
  puts "=> #{message}"
end

prompt("Enter the first number:")
num_one = gets.chomp.to_i
prompt("Enter the second number:")
num_two = gets.chomp.to_i

prompt("#{num_one} + #{num_two} = #{num_one + num_two}")
prompt("#{num_one} - #{num_two} = #{num_one - num_two}")
prompt("#{num_one} * #{num_two} = #{num_one * num_two}")
prompt("#{num_one} / #{num_two} = #{num_one / num_two}")
prompt("#{num_one} % #{num_two} = #{num_one % num_two}")
prompt("#{num_one} ** #{num_two} = #{num_one ** num_two}")
