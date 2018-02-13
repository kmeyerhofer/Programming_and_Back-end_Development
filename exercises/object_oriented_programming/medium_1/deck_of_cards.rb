class Deck
  RANKS = (2..10).to_a + %w(Jack Queen King Ace).freeze
  SUITS = %w[Hearts Clubs Diamonds Spades].freeze
  attr_accessor :deck
  def initialize
    create_deck
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
    if FACE_CARDS.include?(rank) && FACE_CARDS.include?(other_card.rank)
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

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }

drawn
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.
