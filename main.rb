require 'sinatra'
require 'haml'
require_relative 'tic_tac_toe_board.rb'

get '/' do
	@title = 'Home'
	erb :index
end

get '/start_up' do
  @title = "Start Up"
  erb :start_up
end

post '/start_up' do
  "You said '#{params[:message]}'"
end

not_found do
  erb :not_found
end
