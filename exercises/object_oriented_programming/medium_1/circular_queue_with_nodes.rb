require 'pry'
class CircularQueue
  attr_accessor :head, :queue, :age, :current
  def initialize(length)
    setup_queue(length)
    @current = @head
    @age = 0
  end

  def setup_queue(length)
    counter = 1
    @head = Node.new(nil)
    self.current = head
    loop do
      self.current.next_node = Node.new(nil)
      self.current = current.next_node
      counter += 1
      break if counter == length
    end
    current.next_node = @head
    self.queue = @head
  end

  def enqueue(num)
    hash = {}
    hash[age] = num
    self.age += 1
    self.current.value = hash
    self.current = current.next_node
  end

  def dequeue
    while


  end

  def return_node_value
    head_id = head.object_id
    node = head.next_node.object_id
    self.current = head
    while node != head_id
      current.value
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
# queue.enqueue(2)
# queue.enqueue(3)
p queue.queue
p queue.dequeue

# queue = CircularQueue.new(3)
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
