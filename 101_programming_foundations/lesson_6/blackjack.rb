WINNING_VALUE = 21
DEALER_STAY_VALUE = 17
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
  array = new_array.insert(-2, 'and').join(', ')
  array
end

def hit(deck, hand)
  card = deal_cards(deck, 1).flatten
  new_hand = hand << card
  new_hand
end

def aces!(hand)
  hand.find do |array|
    array[2] = 1 if array.include?('Ace') && array[2] != 1
  end
  hand
end

def hand_total!(hand)
  total = hand.map { |array| array[2] }
  sum = total.inject(:+)
  if total.include?(11) && sum > WINNING_VALUE
    new_total = aces!(hand).map { |array| array[2] }
    sum = new_total.inject(:+)
  end
  sum
end

def blackjack_check?(hand_totals)
  hand_totals == WINNING_VALUE ? true : false
end

def initial_board(player_hand, dealer_hnd, message = '', winner = '', wins = [])
  player_total = hand_total!(player_hand)
  prompt("Dealer's hand: #{display_card(dealer_hnd[0])} and an unknown card.")
  prompt("Your hand: #{joiner(player_hand)} Total: #{player_total}.\n\n")
  prompt(message) unless message.empty?
  win(winner, wins) unless winner.empty?
end

def update_board(player_hand, dealer_hand, message = '', winner = '', wins = [])
  player_total = hand_total!(player_hand)
  dealer_total = hand_total!(dealer_hand)
  prompt("Dealer's hand: #{joiner(dealer_hand)}. Total: #{dealer_total}")
  prompt("Your hand: #{joiner(player_hand)}. Total: #{player_total}\n\n")
  prompt(message) unless message.empty?
  win(winner, wins) unless winner.empty?
end

def win(winner, wins)
  prompt("#{winner} wins!\n\n")
  if winner == 'Player'
    wins[0] += 1
  elsif winner == 'Dealer'
    wins[1] += 1
  end
end

def push
  prompt("Push.\n\n")
end

def ask_hit_or_stay
  answer = ''
  loop do
    prompt('Hit or stay?')
    answer = gets.chomp.downcase
    break if answer == 'stay' || answer == 'hit'
    prompt("That is an invalid choice, type 'Hit or 'Stay'.")
  end
  answer
end

def play_again?
  prompt("Play again? (Y or N)\n\n")
  answer = gets.chomp
  answer.downcase.start_with?('y') ? false : true
end

def player_hit(deck, player_hand, dealer_hand, wins)
  player_hand = hit(deck, player_hand)
  player_total = hand_total!(player_hand)
  initial_board(player_hand, dealer_hand) if player_total <= WINNING_VALUE
  if player_total > WINNING_VALUE
    initial_board(player_hand, dealer_hand, 'You Bust.', 'Dealer', wins)
    true
  elsif player_total == WINNING_VALUE
    dealer_turn(deck, player_hand, dealer_hand, wins)
    true
  end
end

def player_turn(deck, player_hand, dealer_hand, wins)
  loop do
    answer = ask_hit_or_stay
    if answer == 'stay'
      dealer_turn(deck, player_hand, dealer_hand, wins)
      break
    elsif answer == 'hit'
      break if player_hit(deck, player_hand, dealer_hand, wins)
    end
  end
end

def calculate_winner(player_hand, dealer_hand, dealer_total, wins)
  player_total = hand_total!(player_hand)
  if dealer_total == player_total
    update_board(player_hand, dealer_hand, 'Push')
  elsif dealer_total > WINNING_VALUE
    update_board(player_hand, dealer_hand, 'Dealer Bust.', 'Player', wins)
  elsif player_total > dealer_total
    update_board(player_hand, dealer_hand, '', 'Player', wins)
  elsif player_total < dealer_total && dealer_total <= WINNING_VALUE
    update_board(player_hand, dealer_hand, '', 'Dealer', wins)
  end
end

def dealer_turn(deck, player_hand, dealer_hand, wins)
  loop do
    dealer_total = hand_total!(dealer_hand)
    if dealer_total < DEALER_STAY_VALUE
      update_board(player_hand, dealer_hand)
      dealer_hand = hit(deck, dealer_hand)
    else
      calculate_winner(player_hand, dealer_hand, dealer_total, wins)
      break
    end
  end
end

wins = [0, 0]

loop do
  deck = initialize_deck
  player_hand = initial_hand(deck)
  dealer_hand = initial_hand(deck)
  player_total = hand_total!(player_hand)
  dealer_total = hand_total!(dealer_hand)
  initial_board(player_hand, dealer_hand)

  if blackjack_check?(player_total) && blackjack_check?(dealer_total)
    update_board(player_hand, dealer_hand, 'Push', '')
  elsif blackjack_check?(player_total) && !blackjack_check?(dealer_total)
    dealer_turn(deck, player_hand, dealer_hand, wins)
  elsif !blackjack_check?(player_total) && blackjack_check?(dealer_total)
    update_board(player_hand, dealer_hand, '', 'Dealer', wins)
  elsif !blackjack_check?(player_total) && !blackjack_check?(dealer_total)
    player_turn(deck, player_hand, dealer_hand, wins)
  end
  prompt('Score (Best of 5)')
  prompt("Player: #{wins[0]}.")
  prompt("Dealer: #{wins[1]}.")
  break if wins[0] == 5 || wins[1] == 5
  break if play_again?
end
