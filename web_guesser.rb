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
      if guess > @@secret_number + 5
        message = "Way too high!"
      else
        message = "Too high!"
      end
    elsif guess < @@secret_number
      if guess < @@secret_number - 5
        message = "Way too low!"
      else
        message = "Too low!"
      end
    else
      message = "You got it right! The SECRET NUMBER is #{@@secret_number}."
    end
    return message
  end

  def match_color_with_message(message)
    if message == "Way too high!"
      color = "#ff0000"
    elsif message == "Too high!"
      color = "#ffcccc"
    end
    color
  end

end

wg = WebGuesser.new
get '/' do
  guess = params['guess']
  if guess
    message = wg.check_guess(guess)
    color = wg.match_color_with_message(message)
  end
  erb :index, :locals => {:message => message, :color => color}
end
