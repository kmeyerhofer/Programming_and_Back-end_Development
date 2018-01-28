class Wallet
  include Comparable


  def initialize(amount)
    @amount = amount
  end

  protected
  attr_reader :amount

  def <=>(other_wallet)
    self.amount <=> other_wallet.amount
  end
end

bills_wallet = Wallet.new(500)
pennys_wallet = Wallet.new(465)
if bills_wallet > pennys_wallet
  puts 'Bill has more money than Penny'
elsif bills_wallet < pennys_wallet
  puts 'Penny has more money than Bill'
else
  puts 'Bill and Penny have the same amount of money.'
end
