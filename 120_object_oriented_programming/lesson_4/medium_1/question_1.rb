class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

# Ben is correct because @balance has a getter method
ben = BankAccount.new(1)
p ben.positive_balance?
