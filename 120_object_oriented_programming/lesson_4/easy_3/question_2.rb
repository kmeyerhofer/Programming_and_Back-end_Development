class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def self.hi # Fix
    greeting = Greeting.new
    greeting.greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

Hello.hi
