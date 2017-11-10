require 'pry'
VALID_CHOICES = %w(rock paper scissors lizard spock)
SHORTENED_CHOICES = %w(r p sc l sp)

def prompt(message)
  puts("=> #{message}")
end

def win?(first, second)
  (first == 'scissors' && second == 'paper') ||
    (first == 'paper' && second == 'rock') ||
    (first == 'rock' && second == 'lizard') ||
    (first == 'lizard' && second == 'spock') ||
    (first == 'spock' && second == 'scissors') ||
    (first == 'scissors' && second == 'lizard') ||
    (first == 'lizard' && second == 'paper') ||
    (first == 'paper' && second == 'spock') ||
    (first == 'spock' && second == 'rock') ||
    (first == 'rock' && second == 'scissors')
end

def lengthener(player_choice)
  case player_choice
  when 'r'
    VALID_CHOICES[0]
  when 'p'
    VALID_CHOICES[1]
  when 'sc'
    VALID_CHOICES[2]
  when 'l'
    VALID_CHOICES[3]
  when 'sp'
    VALID_CHOICES[4]
  end
end

def display_at_five_wins(contender, player)
  prompt("The Grand winner with #{contender} wins, is #{player}!")
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie.")
  end
end

player_counter = 0
computer_counter = 0
loop do
  choice = ''
  loop do
    prompt("Type one: #{VALID_CHOICES.join(', ')}.
    Or type #{SHORTENED_CHOICES.join(', ')}")
    either_choice = gets.chomp.downcase
    if SHORTENED_CHOICES.include?(either_choice)
      choice = lengthener(either_choice)
    else
      choice = either_choice
    end

    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That's not a valid choice")
    end
  end

  computer_choice = VALID_CHOICES.sample
  prompt("You chose #{choice} and the computer chose #{computer_choice}")
  display_results(choice, computer_choice)

  if win?(choice, computer_choice) then player_counter += 1 end
  if win?(computer_choice, choice) then computer_counter += 1 end
  if player_counter > 4
    display_at_five_wins(player_counter, 'You')
    break
  elsif computer_counter > 4
    display_at_five_wins(computer_counter, 'Computer')
    break
  end

  prompt("Do you want to play again? (y/n)")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
prompt("Thank you for playing. Goodbye!")
