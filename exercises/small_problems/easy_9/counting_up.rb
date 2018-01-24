def sequence(num)
  array = []
  1.upto(num) {|number| array << number}
  array
end

p sequence(5) == [1, 2, 3, 4, 5]
p sequence(3) == [1, 2, 3]
p sequence(1) == [1]
