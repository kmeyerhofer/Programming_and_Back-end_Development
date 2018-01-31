class CircularQueue
  attr_accessor :head, :queue
  def initialize(length)
    setup_queue(length)
  end

  def setup_queue(length)
    counter = 1
    @head = Node.new(nil)
    current = @head
    loop do
      current.next_node = Node.new(nil)
      current = current.next_node
      counter += 1
      break if counter == length
    end
    current.next_node = @head
    self.queue = @head
  end

  def enqueue(num)
    head.value = num
  end
end

class Node
  attr_accessor :value, :next_node
  def initialize(hash)
    @value = hash
  end
end



queue = CircularQueue.new(3)
queue.enqueue(1)
p queue.queue
# puts queue.dequeue == nil
#
# queue.enqueue(1)
# queue.enqueue(2)
# puts queue.dequeue == 1
#
# queue.enqueue(3)
# queue.enqueue(4)
# puts queue.dequeue == 2
#
# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)
# puts queue.dequeue == 5
# puts queue.dequeue == 6
# puts queue.dequeue == 7
# puts queue.dequeue == nil
#
# queue = CircularQueue.new(4)
# puts queue.dequeue == nil
#
# queue.enqueue(1)
# queue.enqueue(2)
# puts queue.dequeue == 1
#
# queue.enqueue(3)
# queue.enqueue(4)
# puts queue.dequeue == 2
#
# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)
# puts queue.dequeue == 4
# puts queue.dequeue == 5
# puts queue.dequeue == 6
# puts queue.dequeue == 7
# puts queue.dequeue == nil
