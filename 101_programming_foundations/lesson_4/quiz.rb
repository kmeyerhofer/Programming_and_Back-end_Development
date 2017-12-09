def change_case(sentence, new_case)
  case new_case
  when :snake
    snake(sentence)
  when :camel
    camel(sentence)
  when :upper_snake
    upper_snake(sentence)
  else
    puts 'Invalid case type'
  end
end

def upper_snake(str)
  words = str.split
  current_word = 0

  loop do
    break if current_word == words.size

    words[current_word].upcase!
    current_word += 1
  end

  words.join('_')
end

def camel(str)
  words = str.split(' ')
  counter = 0

  while counter < words.size
    words[counter] = words[counter].capitalize

    counter = counter + 1
  end

  words.join
end

def snake(str)
  words = str.split
  current_word = 0

  loop do
    words[current_word].downcase!

    current_word += 1
    break if current_word >= words.size
  end

  words.join('_')
end

sentence = 'The sky was blue'
change_case(sentence, :snake) # => 'the_sky_was_blue'

sentence = 'The sky was blue'
change_case(sentence, :camel) # => 'TheSkyWasBlue'

sentence = 'The sky was blue'
change_case(sentence, :upper_snake) # => 'THE_SKY_WAS_BLUE'



array = {:a => "a", :b => "b"}
p array.select {|num| num}.object_id
p array.object_id
