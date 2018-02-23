def select(arr)
  true_array = []
  counter = 0
  while counter < arr.size
    true_array << arr[counter] if yield(arr[counter])
    counter += 1
  end

  true_array
end


array = [1, 2, 3, 4, 5]

p select(array) { |num| num.odd? }      # => [1, 3, 5]
p select(array) { |num| puts num }      # => [], because "puts num" returns nil and evaluates to false
p select(array) { |num| num + 1 }       # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true
