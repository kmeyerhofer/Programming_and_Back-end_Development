class GuessingGame
  attr_reader :upper, :lower
  attr_accessor :number, :guesses, :answer
  def initialize(lower, upper)
    @lower = lower
    @upper = upper
    reset
  end

  def random_num(lower, upper)
    self.number = rand(lower..upper)
  end

  def play
    reset
    loop do
      puts "You have #{guesses} guesses remaining."
      user_number
      if answer == number
        puts 'You win!'
        break
      elsif answer > upper || answer < lower
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
    puts "#{message}Enter a number between #{lower} and #{upper}:"
    self.answer = gets.chomp.to_i
  end
  def size_of_range
    upper - lower
  end

  def reset
    @number = random_num(lower, upper)
    @guesses = Math.log2(size_of_range).to_i + 1
    @answer = ''
  end

  def too_high
    puts 'Your guess is too high.'
  end

  def too_low
    puts 'Your guess is too low.'
  end
end


game = GuessingGame.new(501, 1500)
game.play
puts 'new game'
game.play
