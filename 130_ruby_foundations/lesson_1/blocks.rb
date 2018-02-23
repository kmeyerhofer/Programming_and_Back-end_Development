def hello
  yield
  'hello!'
end

# puts hello { puts 'hi' }

def echo(str)
  yield if block_given?
  str
end

# echo                                          # => ArgumentError: wrong number of arguments (0 for 1)
# echo("hello!")                                # => "hello!"
# echo("hello", "world!")                       # => ArgumentError: wrong number of arguments (2 for 1)

# this time, called with an implicit block
# echo { puts "world" }                         # => ArgumentError: wrong number of arguments (0 for 1)
# echo("hello!") { puts "world" }               # => "hello!"
# echo("hello", "world!") { puts "world" }      # => ArgumentError: wrong number of arguments (2 for 1)


# method implementation
def say(words)
  yield if block_given?
  puts "> " + words
end

# method invocation
say("hi there") do
  system 'clear'
end                                                # clears screen first, then outputs "> hi there"

def increment(number)
  if block_given?
    yield(number + 1)
  else
    number + 1
  end
end

increment(5) do |num|
  puts num
end

def test
  yield(1, 2)
end

test {|num| puts num }

def test2
  yield(1)
end

test2 do |num1, num2|
  puts "#{num1} #{num2}"
end

def compare(str)
  puts "Before: #{str}"
  after = yield(str)
  puts "After: #{after}"
end

compare('hello') { |word| word.upcase }
