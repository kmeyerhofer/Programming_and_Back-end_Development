require 'pry'
class Move
  VALUES = %w[rock paper scissors lizard spock]

  def initialize(value)
    @value = value if VALUES.include?(value)
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def >(other_move)
    (scissors? && (other_move.paper? || other_move.lizard?)) ||
      (paper? && (other_move.rock? || other_move.spock?)) ||
      (rock? && (other_move.lizard? || other_move.scissors?)) ||
      (lizard? && (other_move.spock? || other_move.paper?)) ||
      (spock? && (other_move.scissors? || other_move.rock?))
  end

  def <(other_move)
    (rock? && (other_move.paper? || other_move.spock?)) ||
      (paper? && (other_move.scissors? || other_move.lizard?)) ||
      (scissors? && (other_move.rock? || other_move.spock?)) ||
      (lizard? && (other_move.rock? || other_move.scissors?)) ||
      (spock? && (other_move.paper? || other_move.lizard?))
  end

  def to_s
    @value
  end
end

class Score
  attr_accessor :wins, :max_wins

  def initialize(max_wins)
    @max_wins = max_wins
    @wins = 0
  end

  def win?
    wins >= max_wins
  end

  def to_s
    wins
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    self.score = Score.new(10)
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
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
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
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
    puts "Best of #{human.score.max_wins}. Score:"
    puts "#{human.name} - #{human.score.wins}."
    puts "#{computer.name} - #{computer.score.wins}"
  end

  def calculate_scores
    if human.move > computer.move
      human.score.wins += 1
    elsif human.move < computer.move
      computer.score.wins += 1
    end
  end

  def display_message(type)
    if type == 'welcome'
      puts "Welcome to Rock, Paper, Scissors, Lizard, Spock, #{human.name}!"
    elsif type == 'goodbye'
      puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock, #{human.name}!"
    end
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
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
