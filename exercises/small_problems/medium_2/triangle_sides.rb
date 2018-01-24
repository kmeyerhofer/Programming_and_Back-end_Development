def triangle(one, two, three)
  num_array = [one, two, three].sort
  if (num_array[0] + num_array[1]) > num_array[2] && one > 0 && two > 0 && three > 0
    if ((one<=>two)<=>(three<=>two)).zero?
      :equilateral
    elsif one != two && two != three && one != three
      :scalene
    elsif ((one<=>two)>(two<=>three)) != 0 || ((one<=>three)>(three<=>two)) != 0
      :isosceles
    end
  else
    :invalid
  end
end

p triangle(3, 3, 3) == :equilateral
p triangle(3, 3, 1.5) == :isosceles
p triangle(3, 4, 5) == :scalene
p triangle(0, 3, 3) == :invalid
p triangle(3, 1, 1) == :invalid
