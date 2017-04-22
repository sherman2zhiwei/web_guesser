require 'sinatra'
require 'sinatra/reloader'

set :SECRET_NUMBER, rand(100)
message = ""

def check_guess(guess)
	if guess != nil and guess != ""
		guess = guess.to_i
		if guess - SECRET_NUMBER > 5
			message = "Way too high!<p></p>"

		elsif SECRET_NUMBER - guess > 5
			message = "Way too low!<p></p>"

		elsif guess - SECRET_NUMBER > 0
			message = "Too high!<p></p>"

		elsif SECRET_NUMBER - guess > 0
			message = "Too low!<p></p>"

		elsif SECRET_NUMBER == guess
			message = "You got it right!<p></p>
			THE SECRET NUMBER IS #{SECRET_NUMBER}"
					
		else
			message = ""
		end
	end
end

get '/' do
	guess = params['guess']	
	message = check_guess(guess)
	erb :index, :locals => {:message => message, :number => SECRET_NUMBER}
end