require 'sinatra'
# require 'data_mapper'
# require 'dm-types'
# require "dm-core"
require_relative 'tic_tac_toe_board.rb'
require_relative 'tic_tac_toe_rules.rb'
# DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/game.db")
#
# class Game
#   include DataMapper::Resource
#
#   property :player_one_marker, 	String, :key => true
#   property :player_two_marker, 	String, :key => true
#   property :rules, Object, :key => true, :required => false
#
# end
#
# DataMapper.finalize.auto_migrate!
get '/' do
	@title = 'Home'
	erb :index
end

get '/settings' do
  @title = "Game Settings"
  erb :settings
end

post '/settings' do
	@title = "Game Settings"
  $player_one_marker = params[:player_one_marker]
	$game = TicTacToeRules.new(TicTacToeBoard.new, first_player: params[:player_one_marker] , player_one_marker: params[:player_one_marker], player_two_marker: params[:player_two_marker])
  erb :settings_done
end

get '/play_game' do
	@title = "Game"
  #$player_one_marker
	erb :play_game
end

get '/end_game' do
	@title = "Game Over"
	erb :end_game
end

put "/end_game" do
  redirect '/'
end

not_found do
	@title = "Not found!"
  erb :not_found
end
