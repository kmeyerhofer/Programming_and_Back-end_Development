def buy_fruit(fruit_array)
  fruit_array.map { |sub_arr| ((sub_arr[0] + ' ') * sub_arr[1]).split(' ') }.flatten
end

p buy_fruit([["apples", 3], ["orange", 1], ["bananas", 2]]) ==
  ["apples", "apples", "apples", "orange", "bananas","bananas"]
