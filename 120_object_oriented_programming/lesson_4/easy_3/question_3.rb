class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

stripey = AngryCat.new(4, 'Stripey')
chewey = AngryCat.new(2, 'Chewey')
