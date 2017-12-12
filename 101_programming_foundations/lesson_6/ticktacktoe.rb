require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]] # diagnals

def prompt(message)
  puts "=> #{message}"
end

def display_board(brd)
  system 'clear'
  puts "You're '#{PLAYER_MARKER}'. Computer '#{COMPUTER_MARKER}'."
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

def computer_places_piece!(brd)
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
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

loop do
  board = initialize_board

  loop do
    display_board(board)

    player_places_piece!(board)
    break if someone_won?(board) || board_full?(board)

    computer_places_piece!(board)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    prompt "#{detect_winner(board)} wins!"
  else
    prompt "It's a tie!"
  end
  prompt 'Play again? (y or n)'
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
prompt 'Thanks for playing Tic Tac Toe! Goodbye.'
