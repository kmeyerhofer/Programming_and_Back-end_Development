class GuessingGame
  attr_accessor :number, :guesses, :answer
  def initialize
    reset
  end

  def random_num
    self.number = rand(1..100)
  end

  def play
    reset
    loop do
      puts "You have #{guesses} guesses remaining."
      user_number
      if answer == number
        puts 'You win!'
        break
      elsif answer > 100 || answer < 1
        user_number('Invalid guess. ')
      elsif answer > number
        self.guesses -= 1
        too_high
      elsif answer < number
        too_low
        self.guesses -=1
      end
      puts 'You are out of guesses. You lose.' if guesses == 0
      break if guesses == 0
    end
  end

  def user_number(message = '')
    puts "#{message}Enter a number between 1 and 100:"
    self.answer = gets.chomp.to_i
  end

  def reset
    @number = random_num
    @guesses = 7
    @answer = ''
  end

  def too_high
    puts 'Your guess is too high.'
  end

  def too_low
    puts 'Your guess is too low.'
  end
end


game = GuessingGame.new
game.play
puts 'new game'
game.play
