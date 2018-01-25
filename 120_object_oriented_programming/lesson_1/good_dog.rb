# good_dog.rb
#
# class GoodDog
#   attr_accessor :name, :height, :weight
#
#   def initialize(n, h, w)
#     @name = n
#     @height = h
#     @weight = w
#   end
#
#   def change_info(n, h, w)
#     self.name = n
#     self.height = h
#     self.weight = w
#   end
#
#   def speak
#     "#{name} says arf!"
#   end
#
#   def info
#     "#{name} weighs #{weight} and is #{height} tall."
#   end
# end
#
# sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
# puts sparky.info      # => Sparky weighs 10 lbs and is 12 inches tall.
#
# sparky.change_info('Spartacus', '24 inches', '45 lbs')
# puts sparky.info      # => Spartacus weighs 45 lbs and is 24 inches tall.

# class GoodDog
#   @@number_of_dogs = 0
#
#   def initialize
#     @@number_of_dogs += 1
#   end
#
#   def self.total_number_of_dogs
#     @@number_of_dogs
#   end
# end
#
# puts GoodDog.total_number_of_dogs
#
# dog1 = GoodDog.new
# dog2 = GoodDog.new
#
# puts GoodDog.total_number_of_dogs

class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    self.name   = n
    self.height = h
    self.weight = w
  end

  def change_info(n, h, w)
    self.name   = n
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end

  def what_is_self
    self
  end
end


sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
p sparky.what_is_self
