class Cat
  @@cat_total = 0
  def initialize
    @@cat_total += 1
  end

  def self.total
    p @@cat_total
  end
end

kitty1 = Cat.new
kitty2 = Cat.new

Cat.total
