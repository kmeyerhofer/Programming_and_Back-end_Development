def each_with_index(array)
  index = 0
  while index < array.size
    yield(array[index], index)
    index += 1
  end
  array
end

each_with_index([1, 3, 6]) do |value, index|
  puts "#{index} -> #{value**index}"
end
