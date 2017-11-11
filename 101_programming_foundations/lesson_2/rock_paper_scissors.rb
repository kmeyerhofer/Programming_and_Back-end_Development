VALID_CHOICES = { 'r' => 'rock',
                  'p' => 'paper',
                  'sc' => 'scissors',
                  'l' => 'lizard',
                  'sp' => 'spock' }

def prompt(message)
  puts("=> #{message}")
end

def win?(first, second)
  win_hash = { 'scissors' => ['paper', 'lizard'],
               'paper' => ['rock', 'spock'],
               'rock' => ['lizard', 'scissors'],
               'lizard' => ['spock', 'paper'],
               'spock' => ['scissors', 'rock'] }
  win_hash[first].include?(second)
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
