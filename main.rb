require 'sinatra'
require 'data_mapper'
require_relative 'tic_tac_toe_board.rb'
require_relative 'tic_tac_toe_rules.rb'
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/tictactoe.db")

class Game
  include DataMapper::Resource
  property :player_one_marker, String
	property :player_two_marker, String
  property :rules, TicTacToeRules
end
DataMapper.finalize
Game.auto_upgrade!

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
	@rules = TicTacToeRules.new(TicTacToeBoard.new, player_one_marker, player_two_marker)
  erb :settings_end
end

not_found do
	@title = "Not found!"
  erb :not_found
end
