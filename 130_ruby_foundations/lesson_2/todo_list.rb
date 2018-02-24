require 'pry'
class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo)
    raise TypeError, 'Can only add Todo Objects' if todo.class != Todo
    @todos.push(todo)
    @todos
  end

  def <<(todo)
    add(todo)
  end

  def index_error?(index)
    raise IndexError if @todos[index].nil?
  end

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def item_at(index)
    index_error?(index)
    @todos[index]
  end

  def mark_done_at(index)
    item_at(index).done!
  end

  def mark_undone_at(index)
    item_at(index).undone!
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    @todos.delete(item_at(index))
  end

  def done!
    @todos.each_index do |index|
      mark_done_at(index)
    end
  end

  def done?
    @todos.all? { |todo| todo.done? }
  end

  def to_s
    text = "---- #{title} ----\n"
    text << @todos.map(&:to_s).join("\n")
    text
  end

  def to_a
    @todos
  end

  def each
    index = 0
    while index < @todos.size
      yield(@todos[index])
      index += 1
    end
    self
  end

  def select
    new_todo_list = TodoList.new(title)
    each { |todo| new_todo_list << todo if yield(todo) }
    new_todo_list
  end

  def find_by_title(string)
    select { |todo| todo.title == string }.first
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(string)
    todo_to_mark = find_by_title(string)
    todo_to_mark.done!
  end

  def mark_all_done
    each { |todo| todo.done! }
  end

  def mark_all_undone
    each { |todo| todo.undone! }
  end
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

todo1.done!

puts list.mark_all_done
puts list.all_done

puts list.mark_all_undone
puts list
