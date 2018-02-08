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
      choices.insert(-2, separator).join(' ')
    else
      choices.join(' ')
    end
  end

  def select_square(choice_arr)
    choice_arr.select { |num| unmarked_keys.include?(num) }.sample
  end

  def ai_available_moves(player_marker)
    WINNING_LINES.select do |line|
      squares = @squares.values_at(*line)
      markers = squares.map(&:marker)
      two_identical_markers?(markers, player_marker)
    end
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

  private

  def two_identical_markers?(markers, player_marker)
    if markers.count(player_marker) != 2 # HUMAN_MARKER for DEFENSE
      nil
    elsif markers.count(player_marker) == 2 && # HUMAN_MARKER FOR DEFENSE
          markers.count(Square::INITIAL_MARKER) == 1 # INITIAL_MARKER
      true
    else
      markers.min == markers.max
    end
  end

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
  attr_accessor :score, :name
  def initialize(name, marker = nil)
    @name = name
    @marker = marker ? marker : marker_choice
    @score = 0
  end

  def increment_score
    self.score += 1
  end

  def marker_choice
    puts 'Enter a letter as your marker (A-Z):'
    loop do
      player_marker = gets.chomp.upcase
      return player_marker if player_marker.match?(/[a-z]/i) &&
                              player_marker.length == 1
      puts "Sorry, that's not a valid choice."
    end
  end
end

class TTTGame
  COMPUTER_MARKER = 'O'.freeze
  WINS_TO_BEAT_GAME = 5

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(set_name)
    @computer = Player.new('Roomba', COMPUTER_MARKER)
    @current_marker = first_to_move
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

  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      return n unless n.length == n.count(' ') || n.empty?
      puts 'Sorry, must enter a value.'
    end
  end

  def first_to_move
    @current_marker = human.marker
  end

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
    "Thanks for playing Tic Tac Toe, #{human.name}! Goodbye!"
  end

  def display_board(message = '')
    puts message.to_s
    puts "You are: #{human.marker}. Computer is: #{computer.marker}."
    puts "Score: #{human.name}: #{human.score}. #{computer.name}:" \
    "#{computer.score}."
    puts "First to #{WINS_TO_BEAT_GAME} wins, wins the match!"
    puts ''
    board.draw
    puts ''
  end

  def clear_screen_and_display_board(message = '')
    clear
    display_board(message)
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

  def available_offense_moves?
    !board.ai_available_moves(computer.marker).empty?
  end

  def available_defense_moves?
    !board.ai_available_moves(human.marker).empty?
  end

  def choices(player_marker)
    board.ai_available_moves(player_marker).flatten
  end

  def assign_move(player_marker)
    board[board.select_square(choices(player_marker))] = computer.marker
  end

  def ai_moves
    if available_offense_moves?
      assign_move(computer.marker)
    elsif available_defense_moves?
      assign_move(human.marker)
    elsif board.unmarked_keys.include?(5)
      board[5] = computer.marker
    else
      board[board.unmarked_keys.sample] = computer.marker
    end
  end

  def display_result
    if board.winning_marker == human.marker
      human.increment_score
      clear_screen_and_display_board('You won!')
    elsif board.winning_marker == computer.marker
      computer.increment_score
      clear_screen_and_display_board('Computer won!')
    else
      clear_screen_and_display_board('Draw!')
    end
  end

  def play_again?
    answer = nil
    loop do
      puts 'Would you like to play again? (y/n)'
      answer = gets.chomp.downcase
      break if %w[y n].include? answer
      puts 'Sorry, must be y or n'
    end
    answer == 'y'
  end

  def reset
    board.reset
    clear
    @current_marker = first_to_move
    display_board("Let's play again!")
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = computer.marker
    else
      ai_moves
      @current_marker = human.marker
    end
  end

  def human_turn?
    @current_marker == human.marker
  end
end

game = TTTGame.new
game.play
