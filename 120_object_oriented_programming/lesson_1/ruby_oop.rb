# 1. How do we create an object in Ruby?
# 2. Create a module for your class.
# module Bake
#   def oven_temp(temp)
#     puts "Baking at #{temp}F"
#   end
# end
#
#
# class Pizza
#   include Bake
# end
#
# p pepperoni = Pizza.new

class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

p bob = Person.new("Steve")
p bob.name = "Bob"
