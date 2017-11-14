produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

def select_fruit(fruit)
  fruit_hash = {}
  fruit.each do |key, value|
    fruit_hash[key] = value if value.include?('Fruit')
  end
  fruit_hash
end
p select_fruit(produce)
