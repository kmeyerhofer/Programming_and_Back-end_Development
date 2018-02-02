class BeesWax
  attr_accessor :type # added instead of two methods.
  def initialize(type)
    @type = type
  end

  def describe_type
    puts "I am a #{type} of Bees Wax"
  end
end
