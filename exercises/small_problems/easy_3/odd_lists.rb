def oddities(array)
  returned_array = []
  array.each_with_index do |item, index|
    if index.even?
      returned_array << item
    end
  end
  returned_array
end

def evenities(array)
  returned_array = []
  array.each_with_index do |item, index|
    if index.odd?
      returned_array << item
    end
  end
  returned_array
end

p oddities([2, 3, 4, 5, 6]) == [2, 4, 6]
p oddities(['abc', 'def']) == ['abc']
p oddities([123]) == [123]
p oddities([]) == []

p evenities([2, 3, 4, 5, 6]) == [3, 5]
p evenities(['abc', 'def']) == ['def']
p evenities([123]) == []
p evenities([]) == []
