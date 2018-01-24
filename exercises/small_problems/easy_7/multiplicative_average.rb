def show_multiplicative_average(array)
  result = array.map { |num| num.to_f }
  result = result.inject(:*) / result.count
  puts "The result is #{sprintf('%.3f', result)}"
end

show_multiplicative_average([2, 5, 7, 11, 13, 17])
