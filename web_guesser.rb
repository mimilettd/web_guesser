require 'sinatra'
require 'sinatra/reloader'

class WebGuesser
  @@secret_number = rand(100)

  def secret_number
    @@secret_number
  end

  def check_guess(guess)
    guess = guess.to_i
    if guess > @@secret_number
      message = "Too high!"
    elsif guess < @@secret_number
      message = "Too low!"
    else
      message = "You got it right! The SECRET NUMBER is #{@@secret_number}."
    end
    return message
  end

end

wg = WebGuesser.new
get '/' do
  guess = params['guess']
  if guess
    message = wg.check_guess(guess)
  end
  erb :index, :locals => {:message => message}
end
