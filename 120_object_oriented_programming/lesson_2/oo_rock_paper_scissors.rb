require 'pry'
class Move
  attr_accessor :value
  VALUES = %w[rock paper scissors lizard spock]

  def initialize(value)
    @value = value if VALUES.include?(value)
  end

  def to_s
    value
  end
end

class Rock < Move
  def win?(other_move)
    value && (other_move.value == 'lizard' || other_move.value == 'scissors')
  end
end

class Paper < Move
  def win?(other_move)
    value && (other_move.value == 'rock' || other_move.value == 'spock')
  end
end

class Scissors < Move
  def win?(other_move)
    value && (other_move.value == 'paper' || other_move.value == 'lizard')
  end
end

class Lizard < Move
  def win?(other_move)
    value && (other_move.value == 'spock' || other_move.value == 'paper')
  end
end

class Spock < Move
  def win?(other_move)
    value && (other_move.value == 'scissors' || other_move.value == 'rock')
  end
end

class Score
  attr_accessor :wins
  @@max_wins = 0

  def initialize
    @wins = 0
  end

  def self.start_max_wins(value)
    @@max_wins = value
  end

  def self.max_wins
    @@max_wins
  end

  def win?
    wins >= @@max_wins
  end

  def to_s
    wins
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    self.score = Score.new
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.start_with?(' ') || n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose #{Move::VALUES.join(' ')}"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    move_choice(choice)
  end

  def move_choice(choice)
    case choice
    when 'rock'
      self.move = Rock.new(choice)
    when 'paper'
      self.move = Paper.new(choice)
    when 'scissors'
      self.move = Scissors.new(choice)
    when 'lizard'
      self.move = Lizard.new(choice)
    when 'spock'
      self.move = Spock.new(choice)
    end
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    choice = Move::VALUES.sample
    case choice
    when 'rock'
      self.move = Rock.new(choice)
    when 'paper'
      self.move = Paper.new(choice)
    when 'scissors'
      self.move = Scissors.new(choice)
    when 'lizard'
      self.move = Lizard.new(choice)
    when 'spock'
      self.move = Spock.new(choice)
    end
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
    Score.start_max_wins(3)
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp

      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end
    answer == 'n'
  end

  def play
    display_message('welcome')

    loop do
      human.choose
      computer.choose
      winning_sequence
      break if computer.score.win? || human.score.win? || play_again?
    end
    display_message('goodbye')
  end

  def winning_sequence
    display_moves
    display_winner
    calculate_scores
    display_scores
  end

  def display_scores
    puts "Score: (First to #{Score.max_wins} wins)"
    puts "#{human.name} - #{human.score.wins}."
    puts "#{computer.name} - #{computer.score.wins}"
  end

  def calculate_scores
    if human.move.win?(computer.move)
      human.score.wins += 1
    elsif computer.move.win?(human.move)
      computer.score.wins += 1
    end
  end

  def display_message(type)
    if type == 'welcome'
      puts "Welcome to Rock, Paper, Scissors, Lizard, Spock, #{human.name}!"
    elsif type == 'goodbye'
      puts "Thanks for playing, #{human.name}!"
    end
  end

  def display_winner
    if human.move.win?(computer.move) # human.move.win?(computer.move)
      puts "#{human.name} won!"
    elsif computer.move.win?(human.move) # computer.move.win?(computer.move)
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_moves
    puts "#{human.name} chose: #{human.move}."
    puts "#{computer.name} chose: #{computer.move}."
  end
end

RPSGame.new.play
