module CardTable
  def display_welcome_and_rules
    puts "Welcome to the card game, Blackjack! Please, have a seat.\n\n"
    puts "The goal of Twenty-One is to try to get as close to 21 as possible" \
    ", without going over. If you go over 21, it's a 'bust' and you lose.\n\n"
  end

  def display_goodbye_message(message)
    puts "#{message} Thanks for playing Blackjack. Come back soon."
  end

  def display_initial_cards
    display_board_core
    puts dealer_overturned_card
    puts dealer.initial_hand + "\n\n"
  end

  def display_board_core
    clear
    puts "Score: #{human.name} - #{human.wins}. #{dealer.name} - " \
    "#{dealer.wins} (First to #{Game::MAX_WINS} wins)\n#{human.name}'s cards:"
    display_human_card_art
    puts "#{human.hand}\n#{dealer.name}'s cards:"
  end

  def display_cards
    display_board_core
    display_dealer_card_art
    puts dealer.hand + "\n\n"
  end

  def clear
    system('clear') || system('cls')
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

  def display_tie
    display_cards
    puts 'Tie, no one wins.'
  end

  def display_winner(player, loser, message)
    if message == 'busted' && loser == human
      display_initial_cards
    else
      display_cards
    end
    puts "#{loser.name} #{message}!" unless message.empty?
    puts "#{player.name} wins!"
  end
end

module Hand
  def hand_pre_join
    cards.map do |card|
      "#{card.name} of #{Card::SUITS[card.suit]}"
    end
  end

  def hand
    "#{hand_pre_join.join(', ')}\n(Card Total: #{total_card_value})"
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
  attr_accessor :wins, :art_array, :cards
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

  def reset
    self.cards = []
    self.total_card_value = 0
    self.art_array = []
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

class Dealer < Player
  attr_accessor :hits
  def initialize(name)
    @hits = 0
    super
  end

  def reset
    self.hits = 0
    super
  end

  def dealer_rule_text
    "\n#{name} will hit until their card value is greater than or equal to 17."
  end

  def initial_hand
    card_array = hand_pre_join
    card_array[1] = 'and an overturned card.'
    "#{card_array.join(', ')}#{dealer_rule_text}"
  end

  def hand
    "#{hand_pre_join.join(', ')}\n(Card Total: #{total_card_value})" \
    "#{dealer_rule_text}\n#{name} hit #{hits} time#{'s' if hits != 1}."
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
  MAX_WINS = 10
  include CardTable
  attr_accessor :deck, :human, :dealer
  def initialize
    display_welcome_and_rules
    @deck = Deck.new
    @human = Player.new(human_name_set)
    @dealer = Dealer.new('Dealer')
  end

  def start
    deal_cards
    display_initial_cards
    blackjack? ? dealt_card_check : human_turn
  end

  private

  def deal_cards
    deck.deal!(human, 2)
    deck.deal!(dealer, 2)
  end

  def dealt_card_check
    if dealer.blackjack? && human.blackjack?
      end_of_round_check('tie')
    elsif dealer.blackjack?
      increment_wins(dealer)
      end_of_round_check(dealer)
    elsif human.blackjack?
      dealer_turn
    end
  end

  def human_hit_card_check
    if human.blackjack?
      dealer_turn
    elsif human.busted?
      increment_wins(dealer)
      end_of_round_check(dealer, 'busted')
    else
      human_turn
    end
  end

  def dealer_hit_card_check
    if dealer.blackjack?
      calculate_result
    elsif dealer.busted?
      increment_wins(human)
      end_of_round_check(human, 'busted')
    else
      dealer_turn
    end
  end

  def dealer_turn
    if dealer.total_card_value < 17
      deck.deal!(dealer, 1)
      dealer.hits += 1
      dealer_hit_card_check
    elsif dealer.total_card_value >= 17
      calculate_result
    end
  end

  def human_turn
    selection = ''
    loop do
      puts "(h)it or (s)tay?"
      selection = gets.chomp.downcase
      break if validate_hit_or_stay?(selection)
      puts "Invalid entry. (h)it or (s)tay?"
    end
    if selection == 'hit' || selection == 'h'
      deck.deal!(human, 1)
      display_initial_cards
      human_hit_card_check
    elsif selection == 'stay' || selection == 's'
      dealer_turn
    end
  end

  def calculate_result
    human_total = human.total_card_value
    dealer_total = dealer.total_card_value
    if human_total < dealer_total
      increment_wins(dealer)
      end_of_round_check(dealer)
    elsif human_total > dealer_total
      increment_wins(human)
      end_of_round_check(human)
    elsif human_total == dealer_total
      end_of_round_check('tie')
    end
  end

  def end_of_round_check(winner, message = '')
    if winner == human
      display_winner(winner, dealer, message)
    elsif winner == dealer
      display_winner(winner, human, message)
    elsif winner == 'tie'
      display_tie
    end
    !max_wins? && play_again? ? reset : calculate_goodbye_message
  end

  def calculate_goodbye_message
    if compare_wins(human, dealer, true)
      display_goodbye_message('Great job!')
    elsif compare_wins(human, dealer, false)
      display_goodbye_message("Quitting while you're ahead, smart move.")
    elsif compare_wins(dealer, human, true)
      display_goodbye_message('Better luck next time.')
    elsif compare_wins(dealer, human, false)
      display_goodbye_message("Luck doesn't seem to be on your side today.")
    else
      display_goodbye_message('Even stevens.')
    end
  end

  def compare_wins(player_one, player_two, max_wins)
    if max_wins
      player_one.wins > player_two.wins && max_wins?
    else
      player_one.wins > player_two.wins && !max_wins?
    end
  end

  def validate_hit_or_stay?(input)
    input == 's' || input == 'h' || input == 'hit' || input == 'stay'
  end

  def increment_wins(player)
    player.wins += 1
  end

  def human_name_set
    name = ''
    loop do
      puts "What's your name?"
      name = gets.chomp
      return name unless name.length == name.count(' ') || name.empty?
      puts "That doesn't sound like a name I've ever heard of." \
      ' Tell me one more time.'
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
      puts 'Would you like to play again? (y)es or (n)o?'
      answer = gets.chomp.downcase
      break if validate_yes_or_no?(answer)
      puts 'Invalid entry. (y)es or (n)o?'
    end
    answer.start_with?('y')
  end

  def validate_yes_or_no?(input)
    input == 'y' || input == 'n' || input == 'yes' || input == 'no'
  end

  def reset
    self.deck = Deck.new
    human.reset
    dealer.reset
    start
  end
end

Game.new.start
