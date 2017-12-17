INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
FIRST_MOVE = 'choose'.freeze # valid options: 'player', 'computer', or 'choose'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]] # diagnals

def prompt(message)
  puts "=> #{message}"
end

def choice
  case FIRST_MOVE
  when 'player'
    'player'
  when 'computer'
    'computer'
  when 'choose'
    choice_when_choose_selected
  end
end

def board_filler
  "     |     |\n" \
    "-----+-----+-----\n" \
    "     |     |\n"
end

def board_hashes(brd, hash1, hash2, hash3)
  puts "  #{brd[hash1]}  |  #{brd[hash2]}  |  #{brd[hash3]}"
end

def board_data(p_wins, c_wins)
  system 'clear'
  puts "Player: '#{PLAYER_MARKER}'. Computer '#{COMPUTER_MARKER}'.\n"
  puts "Score (Best of 5) - Player: #{p_wins}, Computer: #{c_wins}.\n\n"
end

def display_board(brd, player_wins = 0, computer_wins = 0)
  board_data(player_wins, computer_wins)
  puts '     |     |'
  board_hashes(brd, 1, 2, 3)
  puts board_filler
  board_hashes(brd, 4, 5, 6)
  puts board_filler
  board_hashes(brd, 7, 8, 9)
  puts "     |     |\n\n"
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

def offensive_selection(brd)
  computer_selection_array(brd, find_at_risk_square(brd, COMPUTER_MARKER))
end

def defensive_selection(brd)
  computer_selection_array(brd, find_at_risk_square(brd, PLAYER_MARKER))
end

def computer_places_piece!(brd)
  if empty_squares(brd).include?(offensive_selection(brd))
    brd[offensive_selection(brd)] = COMPUTER_MARKER
  elsif empty_squares(brd).include?(defensive_selection(brd))
    brd[defensive_selection(brd)] = COMPUTER_MARKER
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
    return 'Player' if brd.values_at(*line).count(PLAYER_MARKER) == 3
    return 'Computer' if brd.values_at(*line).count(COMPUTER_MARKER) == 3
  end
  nil
end

def someone_won?(brd)
  !detect_winner(brd).nil?
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

def place_piece!(brd, current_player)
  case current_player
  when 'player'
    player_places_piece!(brd)
  when 'computer'
    computer_places_piece!(brd)
  end
end

def alternate_player(current_player)
  case current_player
  when 'player'
    'computer'
  when 'computer'
    'player'
  end
end

def selection_loops(brd, player_wins, computer_wins, current_player)
  loop do
    display_board(brd, player_wins, computer_wins)
    place_piece!(brd, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(brd) || board_full?(brd)
  end
end

def player_selection(brd, first_move, player_wins, computer_wins, player)
  case first_move
  when 'player'
    selection_loops(brd, player_wins, computer_wins, player)
  when 'computer'
    selection_loops(brd, player_wins, computer_wins, player)
  end
end

def choice_when_choose_selected
  selection = ''
  loop do
    prompt 'Who should go first, Player or Computer?'
    selection = gets.chomp.downcase
    break if selection == 'player' || selection == 'computer'
    prompt 'Sorry, that\'s not a valid choice.'
  end
  selection
end

player_wins = 0
computer_wins = 0

loop do
  board = initialize_board
  selection = choice
  display_board(board, player_wins, computer_wins)
  player_selection(board, selection, player_wins, computer_wins, selection)
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
