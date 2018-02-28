require 'minitest/autorun'
require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < MiniTest::Test
  def test_accept_money
    cash_register = CashRegister.new(300)
    transaction = Transaction.new(30)
    transaction.amount_paid = 30

    previous_amount = cash_register.total_money
    cash_register.accept_money(transaction)
    current_amount = cash_register.total_money

    assert_equal(previous_amount + 30, current_amount)
  end

  def test_change
    register = CashRegister.new(300)
    transaction = Transaction.new(13.98)
    transaction.amount_paid = 24

    assert_equal(10.02, register.change(transaction))
  end

  def test_give_receipt
    cash_register = CashRegister.new(300)
    transaction = Transaction.new(30)
    transaction.amount_paid = 30
    item_cost = 30
    assert_output("You've paid $#{item_cost}.\n") do
      cash_register.give_receipt(transaction)
    end
  end

  def test_prompt_for_payment
    
  end
end
