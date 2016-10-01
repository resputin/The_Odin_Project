class Gameboard

	attr_accessor :board_position

	def gameloop
		@victory = false
		self.new_game
		while @victory == false
			i = 1
			while i < 3
				player_input(i)
				i += 1
				if @victory
					break
				end
			end
		end
	end

	def player_input(player_number)
		puts "Player #{player_number} please choose which square to play"
		input = gets.chomp.to_i
		update(player_number, input)
	end

	def new_game
		@board_position = ["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"]
		draw(@board_position)
	end

	def update(player_number, position)
		if @board_position[position - 1] != "empty"
			puts "That square has already been played please choose another"
			player_input(player_number)
		else
			puts "Player #{player_number} has played on square #{position}"
			@board_position[position - 1] = player_number
			draw(@board_position)
			if victory?(player_number)
				puts "Player #{player_number} wins"
			end
		end
	end

	def draw(board_position)
		i = 0
		while i < 9
			line_separator(board_position[i] , i)
			i += 1
		end

	end

	def line_separator(value, position)
		if value == 1
			value = "X"
		elsif value == 2
			value = "O"
		else
			value = position + 1
		end
		if (position + 1) % 3 == 0
			print " #{value} \n"
			puts "— — — — - -"
		else
			print " #{value} |"
		end
	end

	def victory?(player_number)
		if horizontal_victory?(player_number)
			@victory = true
		elsif vertical_victory?(player_number)
			@victory = true
		elsif diagonal_victory?(player_number)
			@victory = true
		else
			@victory = false
		end
		@victory
	end

	def horizontal_victory?(player_number)
		if @board_position[0] == player_number
			if (@board_position[0] == @board_position[1]) && (@board_position[1] == @board_position[2])
				return true
			end
		elsif @board_position[3] == player_number
			if (@board_position[3] == @board_position[4]) && (@board_position[4] == @board_position[5])
				return true
			end
		elsif @board_position[6] == player_number
			if (@board_position[6] == @board_position[7]) && (@board_position[7] == @board_position[8])
				return true
			end
		else
			return false
		end
	end

	def vertical_victory?(player_number)
		if @board_position[0] == player_number
			if (@board_position[0] == @board_position[3]) && (@board_position[3] == @board_position[6])
				return true
			end
		elsif @board_position[1] == player_number
			if (@board_position[1] == @board_position[4]) && (@board_position[4] == @board_position[7])
				return true
			end
		elsif @board_position[2] == player_number
			if (@board_position[2] == @board_position[5]) && (@board_position[5] == @board_position[8])
				return true
			end
		else
			return false
		end
	end

	def diagonal_victory?(player_number)
		if @board_position[0] == player_number
			if (@board_position[0] == @board_position[4]) && (@board_position[4] == @board_position[8])
				return true
			end
		elsif @board_position[2] == player_number
			if (@board_position[2] == @board_position[4]) && (@board_position[4] == @board_position[6])
				return true
			end
		else
			return false
		end
	end
end
