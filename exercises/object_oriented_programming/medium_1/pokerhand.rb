class Deck
  RANKS = (2..10).to_a + %w(Jack Queen King Ace).freeze
  SUITS = %w[Hearts Clubs Diamonds Spades].freeze
  attr_accessor :deck
  def initialize
    create_deck
  end

  def count
    deck.count
  end

  def draw
    create_deck if deck.empty?
    deck.pop
  end

  def create_deck
    self.deck = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        deck.push(Card.new(rank, suit))
      end
    end
    self.deck = deck.shuffle
  end
end

class Card
  include Comparable
  FACE_CARDS = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other_card)
    if FACE_CARDS.include?(@rank) && FACE_CARDS.include?(other_card.rank)
      face_values(rank) <=> face_values(other_card.rank)
    elsif FACE_CARDS.include?(rank)
      face_values(rank) <=> other_card.rank
    elsif FACE_CARDS.include?(other_card.rank)
      rank <=> face_values(other_card.rank)
    else
      @rank <=> other_card.rank
    end
  end

  def face_values(ranking)
    FACE_CARDS[ranking]
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class PokerHand
  attr_accessor :hand
  def initialize(deck)
    @hand = []
    five_cards(deck)
  end

  def five_cards(deck)
    if deck.count == 5
      self.hand = deck
    else
      5.times { self.hand << deck.draw}
    end
  end

  def print
    puts hand.each(&:to_s)
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def hand_values
    hand.map(&:rank)
  end

  def royal_flush?
    straight_flush? && hand.min.rank == 10

  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    four = array_of_card_duplicates(4)
    true if !four.empty?
  end

  def full_house?
    three_of_a_kind? && pair?
  end

  def flush?
    hand_suits = hand.map(&:suit)
    hand_same_suit = Deck::SUITS.select {|suit| hand_suits.count(suit) == 5}
    true if !hand_same_suit.empty?
  end

  def straight?
    return false if pair? || two_pair?
    sorted_hand = hand.sort
    hand_num_values = hand_values.map {|num| Card::FACE_CARDS.include?(num)? num = Card::FACE_CARDS[num] : num}
    hand_num_values.min == hand_num_values.max - 4
  end

  def three_of_a_kind?
    three = array_of_card_duplicates(3)
    true if !three.empty?
  end

  def two_pair?
    pair = array_of_card_duplicates(2)
    true if pair.count == 4
  end

  def pair?
    pair = array_of_card_duplicates(2)
    true if pair.count == 2
  end

  def array_of_card_duplicates(number)
    hand_values.select { |value| hand_values.count(value) == number }
  end
end


hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'
