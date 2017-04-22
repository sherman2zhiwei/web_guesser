require 'sinatra'
require 'sinatra/reloader'

set :secret_number, rand(100)
set :color, 'white'
@@guesses_left = 5
message = ""

def check_guess(guess)
	@@guesses_left -= 1
	if guess != nil and guess != ""
		guess = guess.to_i
		if guess - settings.secret_number > 5
			settings.color = 'red'
			message = "Way too high!<p></p>"

		elsif settings.secret_number - guess > 5
			settings.color = 'red'
			message = "Way too low!<p></p>"

		elsif guess - settings.secret_number > 0
			settings.color = '#FF6666'
			message = "Too high!<p></p>"

		elsif settings.secret_number - guess > 0
			settings.color = '#FF6666'
			message = "Too low!<p></p>"

		elsif settings.secret_number == guess
			settings.color = 'green'
			message = "You got it right!<p></p>
			THE SECRET NUMBER IS #{settings.secret_number}"
					
		else
			message = ""
		end
	end
end

get '/' do
	guess = params['guess']	
	message = check_guess(guess)
	erb :index, :locals => {:message => message, :color => settings.color}
end