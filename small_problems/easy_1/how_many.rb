vehicles = ['car', 'car', 'truck', 'car', 'SUV', 'truck', 'motorcycle', 'motorcycle', 'car', 'truck']

def count_occurrences(vehicle_list)
  vehicle_hash = {}
  vehicle_list.each do |veh|
    vehicle_hash.store("#{veh}", (vehicle_list.count(veh)))
  end

  vehicle_hash.each do |veh, count|
    puts "#{veh} => #{count}"
  end
end


count_occurrences(vehicles)
