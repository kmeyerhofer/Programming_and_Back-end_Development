def random_age(name = 'Teddy')
  age = rand(20..200)
  "#{name} is #{age} years old!"
end

puts random_age
puts random_age('Michael')
