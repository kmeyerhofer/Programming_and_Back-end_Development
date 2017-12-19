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

def initial_hand(deck)
  deal_cards(deck, 2)
end

def display_card(hand)
  "#{hand[1]} of #{SUITS[hand[0]]}"
end

def prompt(message)
  puts "=> #{message}"
end

def joiner(hand)
  new_array = hand.map { |array| display_card(array) }
  array = new_array.insert(-2, "and").join(', ')
  array
end

def hand_total(hand)
  total = hand.map { |array| array[2] }
  sum = total.inject(:+)
end

def dealer_turn(hand)

end

def blackjack(player_hand, dealer_hand)
  if hand_total(player_hand) == 21 && hand_total(dealer_hand) == 21
    "Push"
  elsif hand_total(player_hand) == 21 && hand_total(dealer_hand) != 21
    "Player"
  elsif hand_total(player_hand) != 21 && hand_total(dealer_hand) == 21
    "Dealer"
  end
end

def hand_count_check(hand)
  case
  when hand_total(hand) > 21
    true
  when hand_total(hand) < 21
    false
  # when =< 17
  #   true
when hand_total(hand) == 21
    #blackjack
  end
end

def hit_or_stay(deck, player_hand, dealer_hand)
  loop do
    prompt("Hit or stay?")
    answer= gets.chomp.downcase
    if answer == 'stay'
      update_board(deck, player_hand, dealer_hand)
      dealer_turn(dealer_hand)
      break
    elsif answer == 'hit'
      new_player_hand = player_hit(deck, player_hand)
      initial_board(deck, new_player_hand, dealer_hand)
      break if hand_count_check(new_player_hand)
      prompt("Bust!")
      update_board(deck, new_player_hand, dealer_hand)
      #break
    else
      prompt("That is an invalid selection, type 'Hit' or 'Stay'.")
    end
  end
end

def initial_board(deck, player, dealer)
  prompt("Dealer's hand: #{display_card(dealer[0])} and an unknown card.")
  prompt("Your hand: #{joiner(player)}.")
end

def update_board(deck, player, dealer)
  prompt("Dealer's hand: #{joiner(dealer)}.")
  prompt("Your hand: #{joiner(player)}.")
end

def player_hit(deck, player_hand)
  hand = deal_cards(deck, 1).flatten
  new_player_hand = player_hand << hand
  new_player_hand
end

# def initialize_game
#   deck = intitalize_deck
#   player_hand = initial_hand(deck)
#   dealer_hand = initial_hand(deck)
#   initial_board(deck, player_hand, dealer_hand)
# end

loop do
  deck = initialize_deck
  player_hand = initial_hand(deck)
  dealer_hand = initial_hand(deck)

  player_total = hand_total(player_hand)
  dealer_total = hand_total(dealer_hand)

  initial_board(deck, player_hand, dealer_hand)



end

  hand_total(player_hand) == 21 ? update_board(deck, player_hand, dealer_hand) : hit_or_stay(deck, player_hand, dealer_hand)
