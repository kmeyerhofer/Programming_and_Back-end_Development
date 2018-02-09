require 'pry'

module Emojiable
  SUITS = {
    'hearts' => "\u2665 ",
    'diamonds' => "\u2666 ",
    'clubs' => "\u2663 ",
    'spades' => "\u2660 "
  }.freeze
end

module Hand
  include Emojiable
  attr_accessor :cards

  def hand_pre_join
    cards.map do |card|
      "#{card.name} of #{SUITS[card.suit]} #{card.suit.capitalize}"
    end
  end

  def initial_hand
    card_array = hand_pre_join
    card_array[1] = 'and an overturned card.'
    card_array.join(', ')
  end

  def hand
    hand_pre_join.join(', ') + ". Card Total: #{@total_card_value}"
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
  attr_accessor :total_card_value, :name # change attr_reader for :total_card_value to count cards each time. If an Ace is present, change value as necessary
  def initialize(name)
    @name = name
    @cards = []
    @total_card_value = 0
  end

  # def hit(deck)
  #   deck.deal!(self, 1)
  # end

  def stay; end

  # def total
  #   cards.each { |card| self.card_total += card.value }
  #   card_total
  # end
end

class Dealer < Player
  def hit; end

  def stay; end
end

class Deck
  include Emojiable
  attr_accessor :cards, :deck
  def initialize
    create_deck
  end

  def deal!(player, num)
    num.times do
      rand_card = random_card
      player.total_card_value += rand_card.value
      player.cards.push(deck.delete(rand_card))
    end
  end

  private

  def create_deck
    self.deck = []
    SUITS.each_key do |key|
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
  attr_reader :suit, :name, :value
  def initialize(suit, name, value)
    @suit = suit
    @name = name
    @value = value
  end
end

class Game
  attr_reader :deck, :human, :dealer

  def initialize
    @deck = Deck.new
    @human = Player.new('Player')
    @dealer = Dealer.new('Dealer')
  end

  def start
    deal_cards
    show_initial_cards
    blackjack? ? dealt_card_check : human_turn
  end

  def dealt_card_check
    if dealer.blackjack? && human.blackjack?
      push
    elsif dealer.blackjack?
      win_message(dealer)
    elsif human.blackjack?
      dealer_turn
    end
  end

  def human_hit_card_check
    if human.blackjack?
      dealer_turn
    elsif human.busted?
      win_message(dealer, human, 'busted')
    else
      human_turn
    end
  end

  def dealer_hit_card_check
    if dealer.blackjack?
      calculate_result
    elsif dealer.busted?
      win_message(human, dealer, 'busted')
    else
      dealer_turn
    end
  end

  def calculate_result
    if human.total_card_value < dealer.total_card_value
      win_message(dealer)
    elsif human.total_card_value > dealer.total_card_value
      win_message(human)
    elsif human.total_card_value == dealer.total_card_value
      push
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
      puts "'Hit' or 'Stay'?"
      selection = gets.chomp.downcase
      break if selection == 'hit' || selection == 'stay'
      puts "Invalid selection. 'Hit' or 'Stay'?"
    end
    case selection
    when 'hit'
      deck.deal!(human, 1)
      show_initial_cards
      human_hit_card_check
    when 'stay'
      dealer_turn
    end
  end

  def show_initial_cards
    puts human.hand
    puts dealer.initial_hand + "\n\n"
  end

  def display_cards
    puts human.hand
    puts dealer.hand + "\n\n"
  end

  def blackjack?
    human.blackjack? || dealer.blackjack?
  end

  def push
    display_cards
    puts "Push, tie, no one wins."
  end

  def win_message(player, losing_player = '', message ='')
    display_cards
    puts "#{player.name} wins!"
    puts "#{losing_player.name} #{message}!" unless message.empty?
  end

  def deal_cards
    deck.deal!(human, 2)
    deck.deal!(dealer, 2)
  end
end

Game.new.start
