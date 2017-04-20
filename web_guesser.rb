require 'sinatra'
require 'sinatra/reloader'

random_number = rand(100)

get '/' do
	"Hello, World!"	
end

get '/rand' do
	"THE SECRET NUMBER IS #{random_number}"
end