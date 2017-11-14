def room_size(length, width, meters = true)
  meters ? (length * width) : (length * width * 10.7639).round(2)
end

puts 'Enter the length of the room in meters:'
m_length = gets.chomp.to_f
puts 'Enter the width of the room in meters:'
m_width = gets.chomp.to_f

puts "The area of the room is #{room_size(m_length, m_width)} square meters "+ \
     "(#{room_size(m_length, m_width, false)} square feet.)"
