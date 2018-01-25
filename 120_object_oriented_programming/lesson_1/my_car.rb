class MyCar
  attr_accessor :color
  attr_reader :year, :model
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def speed_up
    @speed += 25
  end

  def brake
    @speed -= 5
  end

  def shut_off
    @speed = 0
  end

  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end

  def info
    "#{year} #{color} #{model}"
  end
end


# puts "Enter the year of your car: "
# year = gets.chomp
# puts "Enter the color of your car: "
# color = gets.chomp
# puts "Enter the model of your car: "
# model = gets.chomp

car = MyCar.new(2008, 'Black', 'Ford Expedition')
p car.info
p car.speed_up
p car.brake
p car.shut_off
p car.color = 'Yellow'
p car.info

car.spray_paint('Blue')
