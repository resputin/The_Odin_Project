def breakchange(cost, bill)
  change = bill - cost
  twenties = denomination(20, change)
  change = change - (twenties * 20)
  tens = denomination(10, change)
  change = change - (tens * 10)
  fives = denomination(5, change)
  change = change - (fives * 5)
  ones = denomination(1, change)
  change = change - ones
  quarters = denomination(0.25, change)
  change = change - (quarters * 0.25)
  dimes = denomination(0.1, change)
  change = change - (dimes * 0.1)
  nickels = denomination(0.05, change)
  change = change - (nickels * 0.05)
  pennies = denomination(0.01, change)
  puts "You get back:"
  if twenties >= 1
    puts "#{twenties} 20's"
  end
  if tens >= 1
    puts "#{tens} 10's"
  end
  if fives >= 1
    puts "#{fives} 5's"
  end
  if ones >= 1
    puts "#{ones} 1's"
  end
  if quarters >= 1
    puts "#{quarters} Quarters"
  end
  if dimes >= 1
    puts "#{dimes} dimes"
  end
  if nickels >= 1
    puts "#{nickels} nickesls"
  end
  if pennies >= 1
    puts "#{pennies} pennies"
  end

end


def denomination(bill, change)
  if bill > change
    0
  else
    (change / bill).to_i
  end
end



def breakchange_refactored(cost, bill)
  change = bill - cost
  denominations = [20, 10, 5, 1, 0.25, 0.1, 0.05, 0.01]
  denomination_words = ["Twenty", "Ten", "Five", "One", "Quarter", "Dime", "Nickel", "Penny"]
  denomination_words_pluralized = ["Twenties", "Tens", "Fives", "Ones", "Quarters", "Dimes", "Nickels", "Pennies"]
  i = 0
  amount = 0
  while i < 8
    amount = denomination(denominations[i], change)
    change = change - (amount * denominations[i])
    if amount > 1
      puts "#{amount} #{denomination_words_pluralized[i]}"
    elsif amount == 1
      puts "#{amount} #{denomination_words[i]}"
    end
    i += 1
  end
end




puts "How much did the item cost"
cost = gets.chomp.to_f
puts "How much money did you give?"
bill = gets.chomp.to_f
breakchange_refactored(cost, bill)
