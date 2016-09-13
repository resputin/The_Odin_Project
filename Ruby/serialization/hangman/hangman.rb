require "csv"

class Hangman
	def new_game
		puts "Type load for a save game or new for a new game"
		game_value = gets.chomp.downcase
		if game_value == "load"
			puts "Type what game you would like to load"
			save_load = gets.chomp
			load_game(save_load)
		else
			wordchooser
			generate_spaces(@secret_word)
			@guess_counter = 0
			@incorrect_array = []
			@guessed_letters = []
			gameloop(@secret_word)
		end
	end

	def load_game(save_file)
		contents = CSV.open "save_file.csv", headers: true, header_converters: :symbol
		save_array = contents.find  do |row|
    	row.field(:save_file) == save_file
		end

		@secret_word = save_array[:secret_word]
		@correct_array = array_fixer(save_array[:correct_array])
		@incorrect_array = array_fixer(save_array[:incorrect_array])
		@guessed_letters = array_fixer(save_array[:guessed_letters])
		@guess_counter = save_array[:guess_counter].to_i
		redraw
		gameloop(@secret_word)
	end

	def array_fixer(input)
		output_array = []
		input.scan(/\w/) do |match|
			output_array << match
		end
		output_array
	end

	def wordchooser
		tempword = File.readlines("5desk.txt")[rand(61407)].to_s
		if tempword.length < 6 || tempword.length > 12
			wordchooser
		else
			@secret_word = tempword
			@correct_array = []
			i = 0
			while i < tempword.length - 2
				@correct_array << " _ "
				i += 1
			end
		end
	end

	def generate_spaces(input)
		i = 0
		while i < input.length - 2
			print " _ "
			i += 1
		end
		print "\n"
	end

	def gameloop(input)
		@victory = false
		while !@victory
			if @guess_counter >= 10
				puts "You Lose, your word was #{input}"
				break
			else
				puts "Guess a letter, or type save to save game"
				guess = gets.chomp
				if guess.downcase == "save"
					puts "What would you like to title your save?"
					save_number = gets.chomp
					save_game(save_number, @secret_word, @correct_array, @incorrect_array, @guessed_letters, @guess_counter)
				elsif !already_guessed?(guess)
					guess_check(guess, input)
				end
			end
		end
	end

	def guess_check(guess, input)
		good_guess = false
		input.split("").each_with_index do |e, index| 
			if e.downcase == guess.downcase
				puts "\nThat's Right! \n\n"
				update_correct(guess, index)
				good_guess = true
			end
		end

		unless good_guess
			puts "\nThat's wrong \n\n"
			update_incorrect(guess)
			@guess_counter += 1
		end
	end

	def already_guessed?(letter)
		@guessed_letters.each do |e|
			if letter == e
				puts "You have guessed this letter please try again"
				redraw
				return true
			end
		end
		@guessed_letters << letter
		false
	end


	def update_correct(guess, index)
		@correct_array[index] = guess
		redraw
		if @correct_array.join() == @secret_word[0..@secret_word.length - 3]
			puts "You Win!"
			@victory = true
		end
	end

	def update_incorrect(guess)
		@incorrect_array << guess
		redraw
	end

	def redraw
		output_correct = @correct_array.join()
		print output_correct + "\n"
		output_incorrect = @incorrect_array.join()
		print "Previously guessed letters " + output_incorrect + "\n"
		puts "Guesses left #{10 - @guess_counter}\n\n"
	end

	def save_game(number, secret_word, correct_array, incorrect_array, guessed_letters, guess_counter)
		CSV.open("save_file.csv", "a+b") do |csv|
  		csv << ["#{number}", "#{secret_word}", "#{correct_array}", "#{incorrect_array}", "#{guessed_letters}", "#{guess_counter}"]
  	end
	end

end

a = Hangman.new
a.new_game