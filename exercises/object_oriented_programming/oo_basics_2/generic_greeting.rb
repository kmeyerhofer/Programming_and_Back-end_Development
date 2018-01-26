class Cat
  attr_reader :name
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end

  def self.speak
    puts "Meow!"
  end

  def initialize(name)
    @name = name
  end

  def personal_greeting
    puts "Hello! My name is #{self.name}!"
  end
end

Cat.generic_greeting
kitty = Cat.new('Sophie')
kitty.personal_greeting # The result of kitty.class is 'Cat'
Cat.speak
