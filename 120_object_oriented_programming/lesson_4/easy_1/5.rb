class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

# Pizza has an instance variable
# because it is defined with an '@'

pizza = Pizza.new('cheese')
fruit = Fruit.new('orange')

p pizza.instance_variables
p fruit.instance_variables
