class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231" # Accesses instance variable directly
  end

  def show_template
    template # Accesses instance variable through getter method
  end
end

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231" # Accesses setter method using .self
  end

  def show_template
    self.template # Accesses instance variable through getter method
  end
end
