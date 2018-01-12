def negative(num)
  if num == 0
    num
  elsif num.positive?
    num * -1
  else
    num
  end
end


p negative(5) == -5
p negative(-3) == -3
p negative(0) == 0      # There's no such thing as -0 in ruby
