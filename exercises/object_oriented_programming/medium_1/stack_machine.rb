class EmptyStack < StandardError; end
class InvalidCommand < StandardError; end
class InvalidToken < StandardError; end

require 'pry'

class Minilang
  VALID_COMMANDS = ['-1', '-2', '-3', '-4', '-5', '-6', '-7', '-8', '-9', '10', '-10', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'PUSH', 'ADD', 'SUB', 'MULT', 'DIV', 'MOD', 'POP', 'PRINT']
  attr_accessor :commands, :register, :stack
  def initialize(commands)
    @commands = commands
    @register = 0
    @stack = []
  end

  def validate_stack
    if @register == nil
      raise EmptyStack, 'Empty stack!'
    elsif (@commands.split.select{|command| VALID_COMMANDS.include?(command)}).size != @commands.split.size
      raise InvalidCommand, 'Invalid token'
    end

  end

  def eval
    begin
      minilang
    rescue EmptyStack => e
      puts e
    rescue InvalidCommand => e
      puts e
    end
  end

  def minilang
    commands.split.each do |command|
      case command
      when /[0-9]/
        self.register = command.to_i
      when 'PUSH'
        stack.push(register)
      when 'ADD'
        self.register += stack.pop
      when 'SUB'
        self.register -= stack.pop
      when 'MULT'
        self.register *= stack.pop
      when 'DIV'
        self.register /= stack.pop
      when 'MOD'
        self.register %= stack.pop
      when 'POP'
        self.register = stack.pop
      when 'PRINT'
        puts register unless validate_stack
      end
    end
  end
end


Minilang.new('PRINT').eval
# 0
Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15
Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8
Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5
Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!
Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6
Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12
Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB
Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8
Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
