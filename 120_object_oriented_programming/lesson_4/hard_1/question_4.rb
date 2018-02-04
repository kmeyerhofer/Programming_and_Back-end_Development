module Movable
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency

  def range
    @fuel_efficiency * @fuel_capacity
  end
end

class WheeledVehicle
  include Movable

 def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
   @tires = tire_array
   self.fuel_efficiency = km_traveled_per_liter
   self.fuel_capacity = liters_of_fuel_capacity
 end

 def tire_pressure(tire_index)
   @tires[tire_index]
 end

 def inflate_tire(tire_index, pressure)
   @tires[tire_index] = pressure
 end
end

class Auto < WheeledVehicle
 def initialize
   # 4 tires are various tire pressures
   super([30,30,32,32], 50, 25.0)
 end
end

class Motorcycle < WheeledVehicle
 def initialize
   # 2 tires are various tire pressures
   super([20,20], 80, 8.0)
 end
end

class Seacraft
  include Movable
  attr_accessor :hull_count, :propeller_count

  def initialize(num_propellers, num_hulls, fuel_efficiency, fuel_capacity)
    self.num_propellers = num_propellers
    self.num_hulls = num_hulls
    self.fuel_efficiency = fuel_efficiency
    self.fuel_capacity = fuel_capacity
  end

  def range
    super + 10
  end
end

class Motorboat < Seacraft
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end


class Catamaran < Seacraft
end
