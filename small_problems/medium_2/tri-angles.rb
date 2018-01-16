def triangle(one, two, three)
  num_array = [one, two, three].sort
  if num_array.inject(:+) == 180 && one > 0 && two > 0 && three > 0
    if num_array.include?(90)
      :right
    elsif num_array.any? { |num| num > 90 }
      :obtuse
    else
      :acute
    end
  else
    :invalid
  end
end

p triangle(60, 70, 50) == :acute
p triangle(30, 90, 60) == :right
p triangle(120, 50, 10) == :obtuse
p triangle(0, 90, 90) == :invalid
p triangle(50, 50, 50) == :invalid
