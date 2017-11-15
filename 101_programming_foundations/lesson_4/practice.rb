produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

def select_fruit(fruit)
  fruit_hash = {}
  counter = 0
  fruit_keys = fruit.keys

  loop do
    break if counter == fruit_keys.size
    current_key = fruit_keys[counter]
    current_value = fruit[current_key]

    if current_value == 'Fruit'
      fruit_hash[current_key] = current_value
    end

    counter += 1
  end

  fruit_hash
  # fruit.each do |key, value|
  #   fruit_hash[key] = value if value.include?('Fruit')
  # end
  # fruit_hash
end
p select_fruit(produce)


def double_odd_indices(numbers)
  doubled_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    current_number *= 2 if counter.odd?
    doubled_numbers << current_number

    counter += 1
  end

  doubled_numbers
end
p double_odd_indices([1,2,3,4,5,6,7,8])

def multiply(arr, multiplyer)
  multiplied_num = []
  counter = 0

  loop do
    break if counter == arr.size
    current_number = arr[counter]
    multiplied_num << current_number * multiplyer
    counter += 1
  end
  multiplied_num
end

p multiply([1,4,3,7,2,6], 5)
