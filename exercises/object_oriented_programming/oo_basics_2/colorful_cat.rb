class Cat
  attr_reader :name
  COLOR = 'purple'
  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name} and I'm a #{COLOR} cat!"
  end

  def to_s
    "I'm #{name}!"
  end
end

kitty = Cat.new('Sopha')
puts kitty
