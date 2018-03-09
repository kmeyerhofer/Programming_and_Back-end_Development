class SecretHandshake
  SECRETS = {0 => 'wink', 1 => 'double blink', 2 => 'close your eyes',
             3 => 'jump', 4 => 'reverse'}
  def initialize(num)
    @num = to_binary_string(num).split('')
  end

  def to_binary_string(num)
    if num.class == String && num.match?(/[a-z]/)
      '0'
    elsif num.class == String
      num
    else
      num.to_s(2)
    end
  end

  def commands
    actions = []
    index = 0
    @num.reverse_each do |num|
      actions << SECRETS[index] if num == '1'
      index += 1
    end
    if actions.include?('reverse')
      actions.reverse!.delete('reverse')
      actions
    else
      actions
    end
  end
end
