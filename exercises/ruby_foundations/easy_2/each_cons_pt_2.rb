def each_cons(collection, arg_num)
  counter = 0
  while counter <= collection.size - arg_num
    if arg_num == 1
      yield(collection[counter])
    elsif arg_num == 2
      yield(collection[counter], collection[counter + 1])
    else
      collection_selection = collection[(counter + 1), arg_num - 1]
      yield(collection[counter], collection_selection)
    end
    counter += 1
  end
  nil
end

hash = {}
each_cons([1, 3, 6, 10], 1) do |value|
  hash[value] = true
end
p hash == { 1 => true, 3 => true, 6 => true, 10 => true }

hash = {}
each_cons([1, 3, 6, 10], 2) do |value1, value2|
  hash[value1] = value2
end
p hash == { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
each_cons([1, 3, 6, 10], 3) do |value1, values|
  hash[value1] = values
end
p hash == { 1 => [3, 6], 3 => [6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 4) do |value1, values|
  hash[value1] = values
end
p hash == { 1 => [3, 6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 5) do |value1, values|
  hash[value1] = values
end
p hash == {}
