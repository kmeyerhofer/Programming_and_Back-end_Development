module Walkable
  def walk
    puts "Let's go for a walk."
  end
end

class Cat
  include Walkable
  attr_accessor :name
  def initialize(name)
    @name = name
  end

  def greet
    "Hello! My name is #{name}"
  end
end

kitty = Cat.new('Sophie')
p kitty.greet
kitty.walk
