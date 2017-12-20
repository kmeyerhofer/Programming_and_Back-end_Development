card = """__________
|        |
|5       |
|        |
|        |
|       5|
|________|
"""

puts card


def display_cards(player, dealer)
  dealer_cards = dealer.map do |array|
    """Dealer cards
    __________
    |        |
    |#{array[1] == '10' ? array[1] + '  ' : array[1][0] + '   '}  #{SUITS[array[0]] + '|'}
    |        |
    |        |
    |#{SUITS[array[0]]}    #{array[1] == '10' ? array[1] + '|' : " " + array[1][0] + '|'}
    |________|
    """
  end
  dealer_cards.each { |card_art| puts card_art }
end

SUITS = {
  'hearts' => "\u2665 ",
  'diamonds' => "\u2666 ",
  'clubs' => "\u2663 ",
  'spades' => "\u2660 "
}.freeze

def initialize_cards
  new_cards = {}
  face_cards = { 'Jack' => 10, 'Queen' => 10, 'King' => 10, 'Ace' => 11 }
  (2..10).each { |num| new_cards[num.to_s] = num }
  new_cards.merge!(face_cards)
  new_cards
end

def initialize_deck
  new_deck = {}
  SUITS.each_key { |key| new_deck[key] = {} }
  new_deck.each_pair do |key, _|
    new_deck[key] = initialize_cards
  end
  new_deck
end

def deal_cards(deck, instances)
  hand = []
  instances.times do
    random_suit = deck.keys.shuffle.pop
    random_card = deck[random_suit].keys.shuffle.pop
    card_value = deck[random_suit][random_card]
    hand << [random_suit, random_card, card_value]
    delete_cards_from_deck!(deck, random_suit, random_card)
  end
  hand
end

def delete_cards_from_deck!(deck, suit, card)
  deck[suit].delete(card)
end

display_cards(player, dealer)
