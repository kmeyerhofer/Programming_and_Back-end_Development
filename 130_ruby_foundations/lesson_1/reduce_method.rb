def reduce(array, accumulator = 0)
  index = 0
  while index < array.size
    accumulator = yield(accumulator, array[index])
    index += 1
  end
  accumulator
end


array = [1, 2, 3, 4, 5]

reduce(array) { |acc, num| acc + num }                    # => 15
reduce(array, 10) { |acc, num| acc + num }                # => 25
reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass
