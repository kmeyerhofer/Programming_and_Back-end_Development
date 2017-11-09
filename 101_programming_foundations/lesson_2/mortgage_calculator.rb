def text(message)
  puts "=> #{message}"
end

def valid_number
  text('Please enter a valid number.')
end

def number?(num)
  /^\d+$/.match(num) || /\d{1,}\.\d{1,}/.match(num)
end

text('Welcome to the Mortgage Calculator')

loan_amount = ''
loop do
  text('Enter your loan amount in U.S. Dollars.')
  loan_amount = gets.chomp

  if number?(loan_amount)
    break
  else
    valid_number
  end
end

monthly_interest = ''
loop do
  text('Enter your APR as a whole number.')
  annual_interest = gets.chomp
  if number?(annual_interest)
    monthly_interest = (annual_interest.to_f / 100 / 12.0)
    break
  else
    valid_number
  end
end

loan_duration = ''
loop do
  text('Enter your loan duration in months.')
  loan_duration = gets.chomp
  if number?(loan_duration)
    break
  else
    valid_number
  end
end

monthly_payment = loan_amount.to_i * (monthly_interest / (1 - (1 + monthly_interest)**-loan_duration.to_i))
monthly_payment_rounded = monthly_payment.round(2)

text("Your monthly payment is $#{monthly_payment_rounded}.")
interest_paid = monthly_payment_rounded * loan_duration.to_i - loan_amount.to_i
interest_paid_rounded = interest_paid.round(2)
text("You will pay $#{interest_paid_rounded} in interest.")
