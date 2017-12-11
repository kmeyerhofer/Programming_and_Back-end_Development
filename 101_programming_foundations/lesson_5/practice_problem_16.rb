def uuid
  sep = "-"
  uuid = returns_randomized_array(8) + sep + returns_randomized_array(4) + sep + returns_randomized_array(4) + sep + returns_randomized_array(4) + sep + returns_randomized_array(12)
  print_out(uuid)
end

def print_out(message)
  puts "#{message}"
end

def returns_randomized_array(length)
  arr = []
  length.times do |_|
    arr << rand(16)
  end
  returned_arr = arr.map do |num|
    num.to_s(16)
  end
  returned_arr.join
end

uuid
