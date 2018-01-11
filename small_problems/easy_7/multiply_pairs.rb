def multiply_all_pairs(array_one, array_two)
  products = array_one.map do |num|
    array_two.map { |num_two| num * num_two }
  end
  products.flatten.sort
end

p multiply_all_pairs([2, 4], [4, 3, 1, 2]) == [2, 4, 4, 6, 8, 8, 12, 16]
