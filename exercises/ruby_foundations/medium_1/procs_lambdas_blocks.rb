# Group 1
my_proc = proc { |thing| puts "This is a #{thing}." }
puts my_proc
puts my_proc.class
my_proc.call
my_proc.call('cat')


# Group 2
my_lambda = lambda { |thing| puts "This is a #{thing}" }
my_second_lambda = -> (thing) { puts "This is a #{thing}" }
puts my_lambda
puts my_second_lambda
puts my_lambda.class
my_lambda.call('dog')
my_lambda.call
my_third_lambda = Lambda.new { |thing| puts "This is a #{thing}" }


# Group 3
def block_method_1(animal)
  yield(animal)
end

block_method_1('seal') { |seal| puts "This is a #{seal}."}
block_method_1('seal')


# Group 4
def block_method_2(animal)
  yield(animal)
end

block_method_2('turtle') { |turtle| puts "This is a #{turtle}."}
block_method_2('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end
block_method_2('turtle') { puts "This is a #{animal}."}

# This Proc does not require an argument when #call is invoked.
# Lambdas require arguments when #call is invoked. NameError when Lambda.new is invoked.
# If a method has #yield within, and no block is passed, it will raise LocalJumpError
# Blocks can be given more arguments than are used and no error will be raised.
# Block local variables are scoped at the block level.

# The difference between Procs, Lambdas and Blocks are this:

# Procs do not require arguments when invoked with #call.
# Lambdas require arguments when #call is invoked.
# Blocks can accept many arguments, but raise LocalJumpError when no block is passed to a method
