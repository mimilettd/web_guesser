require 'sinatra'
require 'sinatra/reloader'

class WebGuesser
  @@secret_number = rand(100)

  def secret_number
    @@secret_number
  end

  def reset
    @@secret_number = rand(100)
  end

  def check_guess(guess)
    guess = guess.to_i
    if guess > @@secret_number
      too_high(guess)
    elsif guess < @@secret_number
      too_low(guess)
    elsif guess == @@secret_number
      perfect_guess
    end
  end

  def too_high(guess)
    if guess > @@secret_number + 5
      message = "Way too high!"
    else
      message = "Too high!"
    end
    return message
  end

  def too_low(guess)
    if guess < @@secret_number - 5
      message = "Way too low!"
    else
      message = "Too low!"
    end
    return message
  end

  def perfect_guess
    message = "You got it right! The SECRET NUMBER is #{@@secret_number}."
    reset
    return message
  end


  def match_color_with_message(message)
    if message == "Way too high!"
      color = "#ff0000"
    elsif message == "Too high!"
      color = "#ffcccc"
    elsif message.include?("You got it right!")
      color = "#33cc33"
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
