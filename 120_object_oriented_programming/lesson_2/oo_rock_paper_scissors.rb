module Emojiable
  def add_symbol(value)
    case value
    when 'rock'
      "#{value.capitalize} \u{1F48E}"
    when 'paper'
      "#{value.capitalize} \u{1F4DC}"
    when 'scissors'
      "#{value.capitalize} \u{2702}"
    when 'lizard'
      "#{value.capitalize} \u{1F98E}"
    when 'spock'
      "#{value.capitalize} \u{1f596}"
    end
  end
end

class PlayHistory
  include Emojiable
  attr_accessor :history
  def initialize
    @history = []
  end

  def add(choice)
    history.push(choice)
  end

  def to_s
    history.map { |word| add_symbol(word) }.join(', ')
  end
end

class Move
  include Emojiable
  attr_accessor :value
  VALUES = %w[rock paper scissors lizard spock]
  SHORTENED_VALUES = %w[r p sc l sp]
  WIN_CONDITION = { 'rock' => %w[lizard scissors], 'paper' => %w[rock spock],
                    'scissors' => %w[paper lizard], 'lizard' => %w[spock paper],
                    'spock' => %w[scissors rock] }
  def initialize(value)
    @value = value if VALUES.include?(value)
  end

  def win?(other_move)
    WIN_CONDITION[value].include?(other_move.value)
  end

  def to_s
    add_symbol(value)
  end
end

class Score
  MAX_WINS = 3
  attr_accessor :wins

  def initialize
    @wins = 0
  end

  def win?
    wins >= MAX_WINS
  end

  def to_s
    wins
  end
end

class Player
  attr_accessor :move, :name, :score, :history

  def initialize
    set_name
    self.score = Score.new
    self.history = PlayHistory.new
  end

  def setting_choice(choice)
    history.add(choice)
    case choice
    when 'rock'
      self.move = Move.new(choice)
    when 'paper'
      self.move = Move.new(choice)
    when 'scissors'
      self.move = Move.new(choice)
    when 'lizard'
      self.move = Move.new(choice)
    when 'spock'
      self.move = Move.new(choice)
    end
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.length == n.count(' ') || n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      capitalized_selections = Move::VALUES.map(&:capitalize)
      puts "Please choose: #{capitalized_selections.join(' ')}"
      choice = gets.chomp.downcase
      break if Move::VALUES.include?(choice) ||
               Move::SHORTENED_VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    choice.length <= 2 ? shortened_to_long(choice) : setting_choice(choice)
  end

  def shortened_to_long(choice)
    case choice
    when 'r'
      setting_choice('rock')
    when 'p'
      setting_choice('paper')
    when 'sc'
      setting_choice('scissors')
    when 'l'
      setting_choice('lizard')
    when 'sp'
      setting_choice('spock')
    end
  end
end

class Computer < Player
  def set_name
    self.name = ['T-1000', 'GLaDOS', 'C-3PO'].sample
  end

  def choose
    choice = Move::VALUES.sample
    setting_choice(choice)
  end
end

class R2D2 < Computer # Always chooses rock
  def set_name
    self.name = 'R2D2'
  end

  def choose
    setting_choice('rock')
  end
end

class Hal < Computer # Higher probability to choose scissors, never paper
  def set_name
    self.name = 'Hal'
  end

  def choose
    choice = ['scissors', 'scissors', 'rock', 'lizard', 'spock'].sample
    setting_choice(choice)
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = [R2D2.new, Hal.new, Computer.new].sample
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
    clear_screen
    display_moves
    display_winner
    display_history
    calculate_scores
    display_scores
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def display_scores
    puts "Score: (First to #{Score::MAX_WINS} wins)" \
         "\t#{human.name} - #{human.score.wins}" \
         "\t#{computer.name} - #{computer.score.wins}\n\n"
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
      puts "Welcome to Rock, Paper, Scissors, Lizard, Spock, #{human.name}!\n\n"
    elsif type == 'goodbye'
      puts "Thanks for playing, #{human.name}!"
    end
  end

  def display_winner
    if human.move.win?(computer.move)
      puts "#{human.name} won!\n\n"
    elsif computer.move.win?(human.move)
      puts "#{computer.name} won!\n\n"
    else
      puts "It's a tie!\n\n"
    end
  end

  def display_moves
    puts "#{human.name} chose: #{human.move}."
    puts "#{computer.name} chose: #{computer.move}.\n\n"
  end

  def display_history
    puts "#{human.name}'s play history: #{human.history}"
    puts "#{computer.name}'s play history: #{computer.history}\n\n"
  end
end

RPSGame.new.play
