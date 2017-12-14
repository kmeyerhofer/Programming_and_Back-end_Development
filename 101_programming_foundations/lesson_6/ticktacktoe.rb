require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
FIRST_MOVE = 'choose' # 'computer' or 'choose' are valid options too
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]] # diagnals

def prompt(message)
  puts "=> #{message}"
end

def display_board(brd, player_wins = 0, computer_wins = 0)
  system 'clear'
  puts "Player: '#{PLAYER_MARKER}'. Computer '#{COMPUTER_MARKER}'."
  puts "Score (Best of 5) - Player: #{player_wins}, Computer: #{computer_wins}."
  puts ''
  puts '     |     |'
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts '     |     |'
  puts '-----+-----+-----'
  puts '     |     |'
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts '     |     |'
  puts '-----+-----+-----'
  puts '     |     |'
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts '     |     |'
  puts ''
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def joiner(array, separator = ', ', last_word = 'or')
  new_array = array
  if new_array.count > 2
    new_array.join(separator).insert(-2, "#{last_word} ")
  elsif new_array.count == 2
    new_array.join(' ').insert(-2, "#{last_word} ")
  elsif new_array.count == 1
    new_array[0]
  end
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def find_at_risk_square(brd, marker)
    WINNING_LINES.select do |line|
      brd.values_at(*line).count(marker) == 2
    end
end

def computer_selection_array(brd, available)
  options = available.map do |array|
    array.select do |num|
      empty_squares(brd).include?(num)
    end
  end
  options.flatten.sample
end

def computer_places_piece!(brd)
  defensive_selection = computer_selection_array(brd, find_at_risk_square(brd, PLAYER_MARKER))
  offensive_selection = computer_selection_array(brd, find_at_risk_square(brd, COMPUTER_MARKER))
  if empty_squares(brd).include?(offensive_selection)
    brd[offensive_selection] = COMPUTER_MARKER
  elsif empty_squares(brd).include?(defensive_selection)
    brd[defensive_selection] = COMPUTER_MARKER
  elsif empty_squares(brd).include?(5)
    brd[5] = COMPUTER_MARKER
  else
    square = empty_squares(brd).sample
    brd[square] = COMPUTER_MARKER
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square: #{joiner(empty_squares(brd))}"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt 'Sorry, that\'s not a valid choice.'
  end

  brd[square] = PLAYER_MARKER
end

def both_player_selection(brd, first_move, player_wins, computer_wins)
  case first_move
  when 'player'
    player_places_piece!(brd)
    return true if someone_won?(brd) || board_full?(brd)
    computer_places_piece!(brd)
    return true if someone_won?(brd) || board_full?(brd)
  when 'computer'
    computer_places_piece!(brd)
    display_board(brd, player_wins, computer_wins)
    return true if someone_won?(brd) || board_full?(brd)
    player_places_piece!(brd)
    return true if someone_won?(brd) || board_full?(brd)
  when 'choose'
  end
end

player_wins = 0
computer_wins = 0
selection = ''

def choice
  case FIRST_MOVE
  when 'player'
    'player'
  when 'computer'
    'computer'
  when 'choose'
    selection = ''
    loop do
      prompt "Who should go first, Player or Computer?"
      selection = gets.chomp.downcase
      break if selection == 'player' || selection == 'computer'
    end
    selection
  end
end

loop do
  board = initialize_board
  selection = choice

  loop do
    display_board(board, player_wins, computer_wins)
    break if both_player_selection(board, selection, player_wins, computer_wins)
  end

  if detect_winner(board) == 'Player'
    player_wins += 1
  elsif detect_winner(board) == 'Computer'
    computer_wins += 1
  end

  display_board(board, player_wins, computer_wins)

  if someone_won?(board)
    prompt "#{detect_winner(board)} wins!"
  else
    prompt "It's a tie!"
  end

  break if player_wins == 5 || computer_wins == 5

  prompt 'Play again? (y or n)'
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
prompt 'Thanks for playing Tic Tac Toe! Goodbye.'
