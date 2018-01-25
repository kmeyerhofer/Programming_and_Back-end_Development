
module Flatbed
  def flatbed?
    self.class == MyTruck ? true : false
  end
end

class Vehicle
  attr_accessor :color, :year, :model, :speed
  @@number_of_vehicles = 0

  def initialize(year, color, model)
    @@number_of_vehicles += 1
    @year = year
      @color = color
      @model = model
      @speed = 0
  end

  def self.vehicle_count
    puts "Number of vehicles created: #{@@number_of_vehicles}"
  end

  def self.gas_mileage(gallons, miles)
    @@mpg = miles / gallons
    "#{@@mpg} miles per gallon of gas."
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

end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2
  include Flatbed
  def to_s
    "My truck is: year: #{year}, Color: #{color}, Model: #{model} Speed: #{speed}, Age: #{age}"
  end
  private
  def age
    (Time.new.year - self.year)
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  def to_s
    "My car is: year: #{year}, Color: #{color}, Model: #{model}, Speed: #{speed}, Age: #{age}"
  end
  private
  def age
    (Time.now.year - self.year)
  end
end

car = MyCar.new(2011, 'Black', 'Ford Taurus')

p car.info
p car.speed_up(45)
p car.brake(20)
p car.shut_off
p car.color = 'Yellow'
p car.info
car.spray_paint('Blue')

 p MyCar.gas_mileage(35.0, 270.0)
truck = MyTruck.new(2015, 'Red', 'Ram 1500')
car = MyCar.new(2013, 'Yellow', 'Mercedes')
p car.to_s
p truck.to_s
Vehicle.vehicle_count
p truck.flatbed?
p truck.age
# p MyTruck.ancestors
# p MyCar.ancestors
