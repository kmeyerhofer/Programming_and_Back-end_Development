VALID_CHOICES = { 'r' => 'rock',
                  'p' => 'paper',
                  'sc' => 'scissors',
                  'l' => 'lizard',
                  'sp' => 'spock' }

WIN_HASH = { 'scissors' => ['paper', 'lizard'],
             'paper' => ['rock', 'spock'],
             'rock' => ['lizard', 'scissors'],
             'lizard' => ['spock', 'paper'],
             'spock' => ['scissors', 'rock'] }

def prompt(message)
  puts("=> #{message}")
end

def win?(first, second)
  WIN_HASH[first].include?(second)
end

def display_at_five_wins(wins, player)
  prompt("The Grand winner with #{wins} wins, is #{player}!")
end

def display_results(player, computer, player_wins, computer_wins)
  if win?(player, computer)
    prompt("You won! Wins: #{player_wins}.")
  elsif win?(computer, player)
    prompt("Computer won! Wins: #{computer_wins}.")
  else
    prompt("It's a tie.")
  end
end

player_wins = 0
computer_wins = 0

loop do
  choice = ''
  loop do
    prompt("Type one: #{VALID_CHOICES.values.join(', ')}.
            Or type #{VALID_CHOICES.keys.join(', ')}")
    choice = gets.chomp.downcase

    if VALID_CHOICES.values.include?(choice)
      break
    elsif VALID_CHOICES[choice]
      choice = VALID_CHOICES[choice]
      break
    else
      prompt("That's not a valid choice")
    end
  end

  computer_choice = VALID_CHOICES.values.sample
  prompt("You chose #{choice} and the computer chose #{computer_choice}")
  if win?(choice, computer_choice)
    player_wins += 1
  elsif win?(computer_choice, choice)
    computer_wins += 1
  end
  display_results(choice, computer_choice, player_wins, computer_wins)


  if player_wins > 4
    display_at_five_wins(player_wins, 'You')
    break
  elsif computer_wins > 4
    display_at_five_wins(computer_wins, 'Computer')
    break
  end

  prompt("Do you want to play again? (y to continue, any value to exit)")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing. Goodbye!")
