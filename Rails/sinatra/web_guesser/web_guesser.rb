require "sinatra"
require "sinatra/reloader"
set :secret, rand(100)
get '/' do 
  guess = params['guess'].to_i 
  message = check_guess(guess)
  erb :index, :locals => {:number => settings.secret, :message => message}
end

def check_guess(guess)
  if guess < settings.secret - 5 
         "#{guess} is way too low!" 
      elsif guess > settings.secret + 5 
         "#{guess} is way too high!" 
      elsif guess > settings.secret 
         "#{guess} is too high!" 
      elsif guess < settings.secret 
         "#{guess} is too low!"       
      elsif guess == settings.secret 
         "That's Right! \n\nThe SECRET NUMBER is #{settings.secret} "
      end 
end