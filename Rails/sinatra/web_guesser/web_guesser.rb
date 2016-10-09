require "sinatra"
require "sinatra/reloader"
@@secret = rand(100)
@background_color = nil
@@guesses_left = 5
@@win = false
get '/' do 
  cheat = params['cheat']
  guess = params['guess'].to_i 
  message = check_guess(guess)
  erb :index, :locals => {:number => @@secret, :message => message,
                          :background_color => @background_color, :cheat => cheat}
end

def check_guess(guess)
  if @@win == true
    @@secret = rand(100)
    @@guesses_left = 5
  end

  if guess < @@secret - 5
    @background_color = "red" 
    @@guesses_left -= 1
    message = "#{guess} is way too low! #{@@guesses_left} Guesses Left" 
  elsif guess > @@secret + 5
    @background_color = "red"
    @@guesses_left -= 1 
    message = "#{guess} is way too high! #{@@guesses_left} Guesses Left" 
  elsif guess > @@secret
    @background_color = "#CD5C5C" 
    @@guesses_left -= 1
    message = "#{guess} is too high! #{@@guesses_left} Guesses Left" 
  elsif guess < @@secret
    @background_color = "#CD5C5C" 
    @@guesses_left -= 1 
    message = "#{guess} is too low! #{@@guesses_left} Guesses Left"       
  elsif guess == @@secret 
    @background_color = "green" 
    message = "That's Right! \n\nThe SECRET NUMBER is #{@@secret} "
    @@win = true
  end 

  if @@guesses_left == 0
    @@guesses_left = 5
    message = "You Lost! The secret number was #{@@secret}"
    @@secret = rand(100)
    
  end
  message
end