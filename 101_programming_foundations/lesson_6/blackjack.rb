require 'pry'
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
    if array.include?('Ace') && array[2] != 1
      array[2] = 1
    end
  end
  hand
end

def hand_total!(hand)
  total = hand.map { |array| array[2] }
  sum = total.inject(:+)
  if total.include?(11) && sum > 21
    new_total = aces!(hand).map { |array| array[2] }
    sum = new_total.inject(:+)
  end
  sum
end

def blackjack_check?(hand_totals)
  hand_totals == 21 ? true : false
end

def initial_board(player, dealer, player_total)
  prompt("Dealer's hand: #{display_card(dealer[0])} and an unknown card.")
  prompt("Your hand: #{joiner(player)} Total: #{player_total}.\n\n")
end

def update_board(player, dealer, player_total, dealer_total)
  prompt("Dealer's hand: #{joiner(dealer)}. Total: #{dealer_total}")
  prompt("Your hand: #{joiner(player)}. Total: #{player_total}\n\n")
end

def win(winner)
  prompt("#{winner} wins!\n\n")
end

def push
  prompt("Push.\n\n")
end

def play_again?
  prompt("Play again? (Y or N)\n\n")
  answer = gets.chomp
  answer.downcase.start_with?('y') ? false : true
end

loop do
  deck = initialize_deck
  player_hand = initial_hand(deck)
  dealer_hand = initial_hand(deck)
  player_total = hand_total!(player_hand)
  dealer_total = hand_total!(dealer_hand)

  initial_board(player_hand, dealer_hand, player_total)

  if blackjack_check?(player_total) && blackjack_check?(dealer_total)
    update_board(player_hand, dealer_hand, player_total, dealer_total)
    push
    break unless play_again?
  elsif blackjack_check?(player_total) && !blackjack_check?(dealer_total)
    loop do
      dealer_total = hand_total!(dealer_hand)
      if dealer_total < 17
        update_board(player_hand, dealer_hand, player_total, dealer_total)
        dealer_hand = hit(deck, dealer_hand)
      elsif dealer_total == 21
        update_board(player_hand, dealer_hand, player_total, dealer_total)
        push
        break
      else
        update_board(player_hand, dealer_hand, player_total, dealer_total)
        win('Player')
        break
      end
      break if dealer_total > 21
    end
  elsif !blackjack_check?(player_total) && blackjack_check?(dealer_total)
    update_board(player_hand, dealer_hand, player_total, dealer_total)
    win('Dealer')
  elsif !blackjack_check?(player_total) && !blackjack_check?(dealer_total)
    loop do
      prompt('Hit or stay?')
      answer = gets.chomp.downcase
      if answer == 'stay'
        loop do
          dealer_total = hand_total!(dealer_hand)
          if dealer_total < 17
            update_board(player_hand, dealer_hand, player_total, dealer_total)
            dealer_hand = hit(deck, dealer_hand)
          elsif dealer_total == player_total
            update_board(player_hand, dealer_hand, player_total, dealer_total)
            push
            break
          elsif dealer_total > 21
            update_board(player_hand, dealer_hand, player_total, dealer_total)
            prompt('Dealer Bust!')
            win('Player')
            break
          elsif player_total > dealer_total && dealer_total < 21
            update_board(player_hand, dealer_hand, player_total, dealer_total)
            win('Player')
            break
          elsif player_total < dealer_total && dealer_total <= 21
            update_board(player_hand, dealer_hand, player_total, dealer_total)
            win('Dealer')
            break
          else # debugging
            prompt("player_total: #{player_total}, dealer_total: #{dealer_total}")
            break
          end
          break if dealer_total > 21
        end
        break
      elsif answer == 'hit'
        player_hand = hit(deck, player_hand)
        player_total = hand_total!(player_hand)
        initial_board(player_hand, dealer_hand, player_total)
        if player_total > 21
          prompt('You Bust!')
          win('Dealer')
          break
        elsif player_total == 21
          loop do
            dealer_total = hand_total!(dealer_hand)
            if dealer_total < 17
              update_board(player_hand, dealer_hand, player_total, dealer_total)
              dealer_hand = hit(deck, dealer_hand)
            elsif dealer_total == 21
              update_board(player_hand, dealer_hand, player_total, dealer_total)
              push
              break
            elsif dealer_total > 21
              update_board(player_hand, dealer_hand, player_total, dealer_total)
              prompt('Dealer Bust!')
              win('Player')
              break
            elsif player_total > dealer_total && dealer_total < 21
              update_board(player_hand, dealer_hand, player_total, dealer_total)
              win('Player')
              break
            elsif player_total < dealer_total && dealer_total <= 21
              update_board(player_hand, dealer_hand, player_total, dealer_total)
              win('Dealer')
              break
            else # debugging
              prompt("player_total: #{player_total}, dealer_total: #{dealer_total}")
              break
            end
            break if dealer_total > 21
          end
          break
        end
      else
        prompt("That is an invalid choice, type 'Hit or 'Stay'.")
      end
    end
  end
  break if play_again?
end
