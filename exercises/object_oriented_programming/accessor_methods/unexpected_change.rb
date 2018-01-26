class Person
  def name=(string)
    @first = string.split[0]
    @last = string.split[1]
  end

  def name
    "#{@first} #{@last}"
  end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name
