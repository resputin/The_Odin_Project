    i = 1
    while i <= 8
      (1..8).each do |j|
        print ((8 * j) - i).to_s + " "
      end
      print "\n"
      i += 1
    end

