class Pet
  def run
    'running!'
  end
  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end
  def swim
    'swimming!'
  end
  def fetch
    'fetching'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end

class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

bob = Person.new("Robert")

kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty
bob.pets << bud

p bob.pets                      # => [#<Cat:0x007fd839999620>, #<Bulldog:0x007fd839994ff8>]
