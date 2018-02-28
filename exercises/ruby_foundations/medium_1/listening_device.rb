class Device
  def initialize
    @recordings = []
  end

  def listen
    return if !block_given?
    record(yield)
  end

  def play
    puts @recordings.last
  end

  def record(recording)
    @recordings << recording
  end
end

listener = Device.new
listener.listen { "Hello World!" }
listener.listen
listener.play # Outputs "Hello World!"
