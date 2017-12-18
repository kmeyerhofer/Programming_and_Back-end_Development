require 'pry'
SUITS = {
         'hearts' => "\u2665 ",
         'diamonds' => "\u2666 ",
         'clubs' => "\u2663 ",
         'spades' => "\u2660 "
        }

def initialize_cards
  new_cards = {}
  face_cards = {'Jack' => 10, 'Queen' => 10, 'King' => 10, 'Ace' => 11}
  (2..10).each { |num| new_cards[num.to_s] = num }
  new_cards.merge!(face_cards)
  new_cards
end

def initialize_deck
  new_deck = {}
  SUITS.each_key { |key| new_deck[key] = {} }
  new_deck.each_pair do |key, value|
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

def initial_hands(deck)
  deal_cards(deck, 2)
end

def display_card(hand)
  "#{hand[1]} of #{SUITS[hand[0]]}"
end

def prompt(message)
  puts "=> #{message}"
end

def update_board(player, computer)
  prompt("Dealer has: #{display_card(computer[0])} and an unknown card.")
  prompt("You have: #{display_card(player[0])} " \
         "and #{display_card(player[1])}.")
end


deck = initialize_deck
player = initial_hands(deck)
computer = initial_hands(deck)


update_board(player, computer)
