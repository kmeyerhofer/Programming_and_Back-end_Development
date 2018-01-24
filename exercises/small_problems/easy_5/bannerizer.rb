def print_in_box(message)
  length = message.length
  top_bottom = "+--+"
  middle = "|  |"
  length.times { |_| top_bottom.insert(1, "-") }
  length.times { |_| middle.insert(1, " ") }
  puts top_bottom
  puts middle
  puts "| #{message} |"
  puts middle
  puts top_bottom
end


print_in_box('')
print_in_box('To boldly go where no one has gone before.')
print_in_box('One small step for man, one giant leap for mankind.')
