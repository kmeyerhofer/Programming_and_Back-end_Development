arr = ['10', '11', '9', '7', '8']
sorted_arr = arr.map {|unsorted| unsorted.to_i}.sort.reverse
p sorted_arr

# Simpler solution
# arr.sort do |a,b|
#   b.to_i <=> a.to_i
# end
