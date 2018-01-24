def lights_on(num)
  all_lights = {}
  (1..num).each {|key| all_lights[key] = 1 }
  round = 2
  loop do
    increment_value = round
    increment_by = []
    loop do
      while increment_value <= num
        increment_by << increment_value
        increment_value += round
      end
      break
    end
    increment_by.each {|value| all_lights[value] = light_toggle(all_lights[value])}
    break if round == num
    round += 1
  end
  all_lights.select {|k, v| v == 1 }.keys
end

def light_toggle(value)
  value == 1 ? 0 : 1
end

p lights_on(5) == [1, 4]
p lights_on(10) == [1, 4, 9]
p lights_on(1000)
