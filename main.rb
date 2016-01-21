require 'sinatra'
require_relative 'tic_tac_toe_board.rb'
require_relative 'tic_tac_toe_rules.rb'

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
	$player_two_marker = params[:player_two_marker]
	$game = TicTacToeRules.new(TicTacToeBoard.new, first_player: params[:player_one_marker] , player_one_marker: params[:player_one_marker], player_two_marker: params[:player_two_marker])
  erb :settings_done
end

get '/play_game' do
	@title = "Game"
  @board = $game.get_board
	@board_array = $game.get_array_board
	erb :play_game
end

post '/play_game' do
	@title = "Game"
	$game.game_turn(params[:spot])
	@board = $game.get_board
	@board_array = $game.get_array_board
	erb :play_game
end

get '/end_game' do
	@title = "Game Over"
	erb :end_game
end

post "/end_game" do
  redirect '/'
end

not_found do
	@title = "Not found!"
  erb :not_found
end
