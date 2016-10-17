require 'sinatra'
require 'sinatra/reloader' if development?


secret_code = ComputerPlayer.new.generate_secret_code
new_game(secret_code)
victory = false
@guess_counter = 0

get '/' do

  input = params['input']
  guess = input.split(" ")
  for i in 0..3
    guess[i] = guess[i].to_i        
  end
  new_guess(guess)
  @guess_counter += 1
  output = 
  erb :index, :locals => {:output => output}
end

class Game
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
      # elsif board[board.length - 1][i + 4] == "A"
      #   for j in 0..3
      #     if (board[board.length - 1][((i + j) % 4) + 4] != "Y") && (board[board.length - 1][((i + j) % 4) + 4] != "locked")
      #       guess[((i + j) % 4)] = board[board.length - 1][i]
      #       board[board.length - 1][((i + j) % 4) + 4] = "locked"
      #     end
      #   end
        else
          guess[i] = rand(6)
        end
      end
    end
    guess   
  end
end