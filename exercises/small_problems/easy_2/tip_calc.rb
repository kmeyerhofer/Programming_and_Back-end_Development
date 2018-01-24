def calculate_tip(bill, tip)
  bill * (tip / 100)
end

def calculate_total(bill, tip)
  (bill + tip).round(2)
end

puts 'What is the bill amount?'
bill_amount = gets.chomp.to_f
puts 'What is the tip percentage?'
tip_percent = gets.chomp.to_f

tip_amount = calculate_tip(bill_amount, tip_percent)
bill_total = calculate_total(bill_amount, tip_amount)

puts "The tip is $#{format("%.2f", tip_amount)}."
puts "The total is $#{format("%.2f", bill_total)}."
