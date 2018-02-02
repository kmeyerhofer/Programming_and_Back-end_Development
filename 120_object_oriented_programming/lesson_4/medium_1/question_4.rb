class Greeting
  def greet(greeting)
    puts greeting
  end
end

class Hello < Greeting
  def hi
    greet('Hello')
  end
end

class GoodBye < Greeting
  def bye
    greet('Goodbye')
  end
end
