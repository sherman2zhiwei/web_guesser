require 'sinatra'
require 'sinatra/reloader'

set :secret_number, rand(100)
set :color, 'white'
@@guesses_left = 5
message = ""

def check_guess(guess)
	if guess != nil and guess != ""
		@@guesses_left -= 1
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

def reset_number? 
	if @@guesses_left == 0
		@@guesses_left = 5
		return true
	else
		return false
	end
end

get '/' do
	guess = params['guess']	
	message = check_guess(guess)
	answer = ''

	if reset_number? == true and guess.to_i != settings.secret_number
		message = "You lost! The correct number was #{settings.secret_number}. A new number has been set for you to guess again!"
		settings.secret_number = rand(100)
		settings.color = 'white'
	elsif guess.to_i == settings.secret_number
		settings.secret_number = rand(100)
	end

	cheat_mode = params['cheat']

	if cheat_mode == 'true'
		answer = "<p>Cheat mode on! The answer is #{settings.secret_number}</p>"
	else
		answer = ""
	end


	erb :index, :locals => {:message => message, :color => settings.color, :answer => answer}
end