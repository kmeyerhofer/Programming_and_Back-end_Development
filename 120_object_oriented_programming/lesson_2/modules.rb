module Swim
  def swim
    "swimming!"
  end
end

class Dog
  include Swim
  # ... rest of class omitted
end

class Fish
  include Swim
  # ... rest of class omitted
end
