class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end2

# The class variable @@cats_count increments each time a new Cat is
# instantiated. This code will increase @@cats_count:
cat = Cat.new('fluffy')
