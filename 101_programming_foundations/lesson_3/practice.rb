def determine_position(num)
  if num < 100 && num > 10
    'Between 10 and 100'
  else
    'Outside 10 and 100'
  end
end

puts determine_position(42)

5.times { |num| puts (" " * num) + "The Flintstones Rock!" }

puts "the value of 40 + 2 is #{40 + 2}"


def factors(number)
  dividend = number
  divisors = []
  begin
    break if number <= 0
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end until dividend == 0
  divisors
end

p factors(3)




def fib(first_num, second_num, limit)
  while second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, 15)
puts "result is #{result}"


def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param += ["rutabaga"]
  return a_string_param, an_array_param
end

my_string = "pumpkins"
my_array = ["pumpkins"]
my_string, my_array = tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"


answer = 42

def mess_with_it(some_number)
  some_number += 8
end

new_answer = mess_with_it(answer)

p answer - 8
