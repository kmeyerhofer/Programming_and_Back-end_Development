def bubble_sort!(array)
  loop do
    swapped = false
    (array.count - 1).times do |index|
      next if (array[index] <=> array[index + 1]) == -1
      array[index], array[index + 1] = array[index + 1], array[index]
      swapped = true
    end
    break unless swapped
  end
end

array = [5, 3]
bubble_sort!(array)
p array == [3, 5]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
p array == [1, 2, 4, 6, 7]
#
array = %w(Sue Pete Alice Tyler Rachel Kim Bonnie)
bubble_sort!(array)
p array == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)

array = %w(Zulu Yankee Charlie Bravo Victor Lima November Alpha Kilo Mike
           Delta Foxtrot Hotel Golf Romeo Whiskey Echo India X-ray Juliet Oscar Papa
           Quebec Sierra Tango Uniform)
bubble_sort!(array)
p array
