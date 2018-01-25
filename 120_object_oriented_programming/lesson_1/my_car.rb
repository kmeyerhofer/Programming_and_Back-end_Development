class MyCar
  attr_accessor :color
  attr_reader :year, :model, :speed

  def self.gas_mileage(gallons, miles)
    @@mpg = miles / gallons
    "#{@@mpg} miles per gallon of gas."
  end

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def speed_up(speed)
    @speed += speed
    "You slammed your foot on the accelerator petal and are now traveling #{speed} mph."
  end

  def brake(speed)
    @speed -= speed
    "You depressed the brake petal and are now travelling #{self.speed} mph."
  end

  def shut_off
    @speed = 0
    "You shut off your car and are travelling #{self.speed} mph."
  end

  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end

  def info
    "#{year} #{color} #{model}"
  end

  def to_s
    "Year: #{year}, Color: #{color}, Model: #{model} Speed: #{speed}"
  end
end

car = MyCar.new(2011, 'Black', 'Ford F-250')

p car.info
p car.speed_up(45)
p car.brake(20)
p car.shut_off
p car.color = 'Yellow'
p car.info
car.spray_paint('Blue')

p MyCar.gas_mileage(35.0, 270.0)
p car.to_s
