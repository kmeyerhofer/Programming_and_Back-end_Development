class Cube
  attr_reader :volume # added to access the instance variable @volume
  def initialize(volume)
    @volume = volume
  end
end

cube = Cube.new(25)
p cube.volume
p cube.instance_variable_get('@volume')
