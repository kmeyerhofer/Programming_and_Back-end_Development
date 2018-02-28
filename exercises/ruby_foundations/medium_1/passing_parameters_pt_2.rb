def birds(array)
  yield(array[2..-1])
end

raptor_birds = []
birds(['raven', 'finch', 'hawk', 'eagle', 'falcon']) do
  |raptors| raptor_birds << raptors
end
p raptor_birds.flatten
