module CardTable
  MAX_WINS = 10
  def welcome_message
    puts "Welcome to the card game Blackjack!"
  end

  def show_initial_cards
    display_board_core
    puts dealer_overturned_card
    puts dealer.initial_hand + "\n\n"
  end

  def display_board_core
    clear
    puts "Score: #{human.name} - #{human.wins}. #{dealer.name}" \
    " - #{dealer.wins} (First to #{MAX_WINS} wins)\n#{human.name}'s cards:"
    display_human_card_art
    puts "#{human.hand}\n#{dealer.name}'s cards:"
  end

  def display_cards
    display_board_core
    display_dealer_card_art
    puts dealer.hand + "\n\n"
  end

  def clear
    system 'clear'
  end

  def display_human_card_art
    puts build_art_array(human)
  end

  def display_dealer_card_art
    puts build_art_array(dealer)
  end

  # rubocop:disable Metrics/AbcSize, Metrics/LineLength
  def build_art_array(player)
    player.art_array = []
    card_length = player.cards.size
    player.art_array.push("#{card_top} " * card_length)
    player.art_array.push("#{card_side} " * card_length)
    player.art_array.push(player.cards.map { |card| card_text_top(card) }.join(' '))
    player.art_array.push("#{card_side} " * card_length)
    player.art_array.push(player.cards.map { |card| card_text_middle(card) }.join(' '))
    player.art_array.push("#{card_side} " * card_length)
    player.art_array.push(player.cards.map { |card| card_text_bottom(card) }.join(' '))
    player.art_array.push("#{card_bottom} " * card_length)
  end

  def dealer_overturned_card
    return dealer.art_array if !dealer.art_array.empty?
    card_length = dealer.cards.size
    dealer.art_array.push("#{card_top} " * card_length)
    dealer.art_array.push("#{card_side} " + "|  ????  |")
    dealer.art_array.push(card_text_top(dealer.cards[0]) + " |??    ??|")
    dealer.art_array.push("#{card_side} " + "|    ??? |")
    dealer.art_array.push(card_text_middle(dealer.cards[0]) + " |  ???   |")
    dealer.art_array.push("#{card_side} " * card_length)
    dealer.art_array.push(card_text_bottom(dealer.cards[0]) + " |  ???   |")
    dealer.art_array.push("#{card_bottom} " * card_length)
  end
  # rubocop:enable Metrics/AbcSize, Metrics/LineLength

  def card_top
    "__________"
  end

  def card_side
    "|        |"
  end

  def card_text_top(card)
    "|#{card.name == '10' ? card.name[0..1] + '  ' : card.name[0] + '   '}" \
      "  #{Card::SUITS[card.suit] + '|'}"
  end

  def card_text_middle(card)
    "|   #{Card::SUITS[card.suit]}   |"
  end

  def card_text_bottom(card)
    "|#{Card::SUITS[card.suit]}" + "    " \
      "#{card.name == '10' ? card.name[0..1] + '|' : ' ' + card.name[0] + '|'}"
  end

  def card_bottom
    "|________|"
  end

  def push
    display_cards
    puts 'Push, tie, no one wins.'
    reset if play_again?
  end

  def win_message(player, losing_player = '', message ='')
    puts "\nFinal board state:\n"
    message == 'busted' && player == dealer ? show_initial_cards : display_cards
    puts "#{player.name} wins!"
    puts "#{losing_player.name} #{message}!" unless message.empty?
    reset if !max_wins? && play_again?
  end
end

module Hand
  attr_accessor :cards

  def hand_pre_join
    cards.map do |card|
      "#{card.name} of #{Card::SUITS[card.suit]}"
    end
  end

  def initial_hand
    card_array = hand_pre_join
    card_array[1] = 'and an overturned card.'
    card_array.join(', ')
  end

  def hand
    "#{hand_pre_join.join(', ')}\n(Card Total: #{@total_card_value})"
  end

  def busted?
    total_card_value > 21
  end

  def blackjack?
    total_card_value == 21
  end
end

class Player
  include Hand
  attr_reader :total_card_value, :name
  attr_accessor :wins, :art_array
  def initialize(name)
    @name = name
    @cards = []
    @total_card_value = 0
    @wins = 0
    @art_array = []
  end


  def total_card_value=(value)
    if card_value_reset > 21 && !aces.nil?
      aces.value = 1
      @total_card_value = card_value_reset
    else
      @total_card_value = value
    end
  end

  private

  def aces
    cards.find { |card| card.value == 11 }
  end

  def card_value_reset
    sum = 0
    cards.count.times { |index| sum += cards[index].value }
    sum
  end
end

class Deck
  attr_accessor :cards, :deck
  def initialize
    create_deck
  end

  def deal!(player, num)
    num.times do
      rand_card = random_card
      player.cards.push(deck.delete(rand_card))
      player.total_card_value += rand_card.value
    end
  end

  private

  def create_deck
    self.deck = []
    Card::SUITS.each_key do |key|
      (2..10).each do |num|
        deck.push(Card.new(key, num.to_s, num))
      end
      face_cards = [Card.new(key, 'Jack', 10), Card.new(key, 'Queen', 10),
                    Card.new(key, 'King', 10), Card.new(key, 'Ace', 11)]
      deck.concat(face_cards)
    end
    deck
  end

  def random_card
    deck.sample
  end
end

class Card
  SUITS = { 'hearts' => "\u2665 ", 'diamonds' => "\u2666 ",
            'clubs' => "\u2663 ", 'spades' => "\u2660 " }.freeze

  attr_reader :suit, :name
  attr_accessor :value
  def initialize(suit, name, value)
    @suit = suit
    @name = name
    @value = value
  end
end

class Game
  include CardTable
  attr_reader :human, :dealer
  attr_accessor :deck
  def initialize
    welcome_message
    @deck = Deck.new
    @human = Player.new(human_name_set)
    @dealer = Player.new('Dealer')
  end

  def start
    deal_cards
    show_initial_cards
    blackjack? ? dealt_card_check : human_turn
  end

  private

  def deal_cards
    deck.deal!(human, 2)
    deck.deal!(dealer, 2)
  end

  def dealt_card_check
    if dealer.blackjack? && human.blackjack?
      push
    elsif dealer.blackjack?
      increment_wins(dealer)
      win_message(dealer)
    elsif human.blackjack?
      dealer_turn
    end
  end

  def human_hit_card_check
    if human.blackjack?
      dealer_turn
    elsif human.busted?
      increment_wins(dealer)
      win_message(dealer, human, 'busted')
    else
      human_turn
    end
  end

  def dealer_hit_card_check
    if dealer.blackjack?
      calculate_result
    elsif dealer.busted?
      increment_wins(human)
      win_message(human, dealer, 'busted')
    else
      dealer_turn
    end
  end

  def dealer_turn
    if dealer.total_card_value < 17
      deck.deal!(dealer, 1)
      dealer_hit_card_check
    elsif dealer.total_card_value >= 17
      calculate_result
    end
  end

  def human_turn
    selection = ''
    loop do
      puts "'(h)it' or '(s)tay'?"
      selection = gets.chomp.downcase
      break if validate_input(selection)
      puts "Invalid entry. '(h)it' or '(s)tay'?"
    end
    if selection == 'hit' || selection == 'h'
      deck.deal!(human, 1)
      show_initial_cards
      human_hit_card_check
    elsif selection == 'stay' || selection == 's'
      dealer_turn
    end
  end

  def calculate_result
    h_t = human.total_card_value
    d_t = dealer.total_card_value
    if h_t < d_t
      increment_wins(dealer)
      win_message(dealer)
    elsif h_t > d_t
      increment_wins(human)
      win_message(human)
    elsif h_t == d_t
      push
    end
  end

  def validate_input(input)
    input == 's' || input == 'h' || input == 'hit' || input == 'stay'
  end

  def increment_wins(player)
    player.wins += 1
  end

  def human_name_set
    name = ''
    loop do
      puts "Please enter your name."
      name = gets.chomp
      return name unless name.length == name.count(' ') || name.empty?
      puts 'Sorry, must enter a value.'
    end
  end

  def blackjack?
    human.blackjack? || dealer.blackjack?
  end

  def max_wins?
    human.wins == MAX_WINS || dealer.wins == MAX_WINS
  end

  def play_again?
    answer = ''
    loop do
      puts 'Would you like to play again? (y/n)'
      answer = gets.chomp.downcase
      break if answer.start_with?('y', 'n')
      puts 'Sorry, must be y or n'
    end
    answer.start_with?('y')
  end

  def reset
    self.deck = Deck.new
    human.cards = []
    dealer.cards = []
    human.total_card_value = 0
    dealer.total_card_value = 0
    human.art_array = []
    dealer.art_array = []
    start
  end
end

Game.new.start
