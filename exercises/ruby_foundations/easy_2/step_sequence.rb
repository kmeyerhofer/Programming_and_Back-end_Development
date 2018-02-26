def step(beginning, ending, stepping)
  iterator = beginning
  while iterator <= ending
    yield (iterator)
    iterator += stepping
  end
  iterator
end


step(1, 10, 3) { |value| puts "value = #{value}" }
