class Game
	def gameloop(player1_class = ComputerPlayer, player2_class = HumanPlayer)
		puts "Would you like to guess or create?"
		play = gets.chomp.downcase
		if play == "create"
			player1_class, player2_class = ComputerPlayer, HumanPlayer
		else
			player1_class, player2_class = HumanPlayer, ComputerPlayer
		end

		if player2_class == ComputerPlayer
			secret_code = ComputerPlayer.new.generate_secret_code
		else
			puts "Player one please enter the code"
			secret_code = gets.chomp.split(" ")
			for i in 0..3
				secret_code[i] = secret_code[i].to_i				
			end
		end

		new_game(secret_code)
		victory = false
		@guess_counter = 0
		if player1_class == HumanPlayer
			while !victory && @guess_counter < 12
				puts "Please make your guess"
				guess = gets.chomp.split(" ")

				for i in 0..3
					guess[i] = guess[i].to_i				
				end

				new_guess(guess)

				@guess_counter += 1
				if @victory
					break
				end
			end
		else
			a = ComputerPlayer.new
			while !victory && @guess_counter < 12
				new_guess(a.ai_guess(@board))

				@guess_counter += 1
				if @victory
					break
				end
			end
		end
	end


	def new_game(secret_code)
		@board = []
		@secret_code = secret_code
	end


	def new_guess(new_guess)
		if new_guess == @secret_code
			@victory = true
			puts "You Win!"
			@board = @board << update(new_guess)
			draw(@board, @guess_counter)
		else
			@board = @board << update(new_guess)
			draw(@board, @guess_counter)
		end
	end


	def update(new_guess)
		for i in 0..3
			if new_guess[i] == @secret_code[i]
				new_guess = new_guess << "Y"
			elsif @secret_code.any? { |number| number == new_guess[i] }
				new_guess = new_guess << "A"
			else
				new_guess = new_guess << "N"
			end
		end
		new_guess
	end


	def draw(guess_array, guesses_left)
		i = 0
		while i < @board.length
			p @board[i]
			i += 1
		end
		i = @board.length
		while i < 12
			puts "[-  -  -  -]"
			i += 1
		end
		if @victory
			puts "You won with #{11 - guesses_left} guesses left."
		else
			puts "You have #{11 - guesses_left} guesses left."
		end
	end
end

class HumanPlayer
end

class ComputerPlayer
	def generate_secret_code
		secret_code = []
		for i in 0..3
			secret_code[i] = rand(5) + 1
		end
		secret_code
	end

	def ai_guess(board)
		guess = []
		if board == []
			for i in 0..3
				guess[i] = rand(5) + 1
			end
		else
			for i in 0..3
				if board[board.length - 1][i + 4] == "Y"
					guess[i] = board[board.length - 1][i]
			##
			#	elsif board[board.length - 1][i + 4] == "A"
			#		for j in 0..3
			#			if (board[board.length - 1][((i + j) % 4) + 4] != "Y") && (board[board.length - 1][((i + j) % 4) + 4] != "locked")
			#				guess[((i + j) % 4)] = board[board.length - 1][i]
			#				board[board.length - 1][((i + j) % 4) + 4] = "locked"
			#			end
			#		end
				else
					guess[i] = rand(6)
				end
			end
		end
		guess		
	end
end

a = Game.new
a.gameloop