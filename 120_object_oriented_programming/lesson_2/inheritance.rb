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

pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

p pete.run                # => "running!"
p pete.speak              # => NoMethodError

p kitty.run               # => "running!"
p kitty.speak             # => "meow!"
p kitty.fetch             # => NoMethodError

p dave.speak              # => "bark!"

p bud.run                 # => "running!"
p bud.swim                # => "can't swim!"
