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
  attr_accessor :total_card_value, :name
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
    loop do
      # if blackjack_check?(player_total) && blackjack_check?(dealer_total)
      #   update_board(player_hand, dealer_hand, 'Push', '')
      # elsif blackjack_check?(player_total) && !blackjack_check?(dealer_total)
      #   dealer_turn(deck, player_hand, dealer_hand, wins)
      # elsif !blackjack_check?(player_total) && blackjack_check?(dealer_total)
      #   update_board(player_hand, dealer_hand, '', 'Dealer', wins)
      # elsif !blackjack_check?(player_total) && !blackjack_check?(dealer_total)
      #   player_turn(deck, player_hand, dealer_hand, wins)
      # end

      deal_cards
      show_initial_cards
      first_card_branch

      # break if card_value_check?
      # human_turn
      # break if card_value_check?

      dealer_turn
      # break if card_value_check?
      show_result
      break
    end
  end

  def first_card_branch
    h_b = human.blackjack?
    d_b = dealer.blackjack?
    if h_b && d_b
      push
    elsif h_b && !d_b
      dealer_turn
    elsif !h_b && d_b
      win(dealer)
    elsif !h_b && !d_b
      human_turn
    end
  end

  def show_result
    display_cards
    win_check
  end

  def win_check
    h_t = human.total_card_value
    d_t = dealer.total_card_value
    if !human.busted? && h_t > d_t || dealer.busted?
      win(human)
    elsif !dealer.busted? && d_t > h_t || human.busted?
      win(dealer)
    else
      push
    end
  end

  def dealer_turn
    deck.deal!(dealer, 1) if dealer.total_card_value < 17
  end

  def human_turn
    selection = ''
    loop do
      puts "'Hit' or 'Stay'?"
      selection = gets.chomp.downcase
      break if selection == 'hit' || selection == 'stay'
      puts "Invalid selection. 'Hit' or 'Stay'?"
    end
    if selection == 'hit'
      deck.deal!(human, 1)
      show_initial_cards
      return if card_value_check?
      human_turn
    end
    # human_turn if selection == 'hit'
  end

  def show_initial_cards
    puts human.hand
    puts dealer.initial_hand
  end

  def display_cards
    puts human.hand
    puts dealer.hand
  end

  def bust_check
    h_t = human.busted?
    d_t = dealer.busted?
    if h_t
      # win(dealer)
      true
    elsif d_t
      # win(human)
      true
    end
  end

  def blackjack_check
    h_t = human.blackjack?
    d_t = dealer.blackjack?
    if h_t && d_t
      # push
      true
    elsif h_t
      # win(human)
      true
    elsif d_t
      # win(dealer)
      true
    end
  end

  def push
    display_cards
    puts "Push, tie, no one wins."
  end

  def win(player)
    display_cards
    puts "#{player.name} wins!"
  end

  def deal_cards
    deck.deal!(human, 2)
    deck.deal!(dealer, 2)
  end

  def card_value_check?
    blackjack_check || bust_check
  end
end

Game.new.start

# p game.deck
