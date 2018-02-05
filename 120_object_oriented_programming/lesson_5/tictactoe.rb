require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]] # diagonals
  def initialize
    @squares = {}
    reset
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return squares.first.marker if three_identical_markers?(squares)
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def draw
    puts '     |     |'
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts '     |     |'
  end

  def joiner(delimiter = ', ', separator = 'or')
    choices = unmarked_keys
    if choices.count > 2
      choices = choices.join(delimiter.to_s)
      choices.insert(-2, "#{separator} ")
    elsif choices.count == 2
      choices.join(' ')
      choices.insert(-2, separator)
    else
      choices.join(' ')
    end
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = ' '.freeze

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker
  attr_accessor :score
  def initialize(marker)
    @marker = marker
    @score = 0
  end
end

class TTTGame
  HUMAN_MARKER = 'X'.freeze
  COMPUTER_MARKER = 'O'.freeze
  FIRST_TO_MOVE = HUMAN_MARKER
  WINS_TO_BEAT_GAME = 5

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
  end

  def play
    clear
    display_board(display_welcome_message)
    loop do
      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board if human_turn?
      end
      display_result
      break if num_of_wins?
      break unless play_again?
      reset
    end
    puts display_goodbye_message
  end

  private

  def num_of_wins?
    human.score == WINS_TO_BEAT_GAME || computer.score == WINS_TO_BEAT_GAME
  end

  def clear
    system 'clear'
  end

  def display_welcome_message
    'Welcome to Tic Tac Toe!'
  end

  def display_goodbye_message
    'Thanks for playing Tic Tac Toe! Goodbye!'
  end

  def display_board(message = '')
    puts message.to_s
    puts "You are: #{human.marker}. Computer is: #{computer.marker}."
    puts "Score: You: #{human.score}. Computer: #{computer.score}."
    puts "First to #{WINS_TO_BEAT_GAME} wins, wins the match!"
    puts ''
    board.draw
    puts ''
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_moves
    puts board.joiner
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = human.marker
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
  end

  def increment_score(player)
    player.score += 1
  end

  def display_result
    if board.winning_marker == human.marker
      increment_score(human)
      puts 'You won!'
    elsif board.winning_marker == computer.marker
      increment_score(computer)
      puts 'Computer won!'
    else
      puts 'Draw!'
    end
    clear_screen_and_display_board
  end

  def play_again?
    answer = nil
    loop do
      puts 'Would you like to play again? (y/n)'
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts 'Sorry, must be y or n'
    end
    answer == 'y'
  end

  def reset
    board.reset
    clear
    @current_marker = FIRST_TO_MOVE
    display_board("Let's play again!")
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end
end

game = TTTGame.new
game.play
