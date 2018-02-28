items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end

gather(items) do | *first_three, last |
  puts "#{first_three.join(', ')}"
  puts last
end

gather(items) do | first, *second_third, fourth |
  puts first
  puts "#{second_third.join(', ')}"
  puts fourth
end

gather(items) do | first, *everything_else |
  puts first
  puts "#{everything_else.join(', ')}"
end

gather(items) do | first, second, third, fourth |
  puts "#{first}, #{second}, #{third}, and #{fourth}"
end
