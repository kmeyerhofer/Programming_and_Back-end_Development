class CircularQueue
  attr_accessor :buffer, :add, :length, :remove
  def initialize(length)
    @buffer = Array.new(length)
    @length = length
    @add = 0
    @remove = 0
  end

  def enqueue(num)
    self.remove += 1 if buffer[adding_index] != nil
    self.buffer[adding_index] = num
    self.add += 1
  end

  def adding_index
    add % length
  end

  def removing_index
    remove % length
  end

  def dequeue
    return nil if buffer.count(nil) == length
    self.buffer[removing_index] = nil
    self.remove += 1
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
