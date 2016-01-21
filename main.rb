require 'sinatra'
require_relative 'tic_tac_toe_board.rb'
require_relative 'tic_tac_toe_rules.rb'
enable :sessions
get '/' do
	@title = 'Home'
	$game = nil
	erb :index
end

get '/settings' do
  @title = "Game Settings"
	$game = nil
  erb :settings
end

post '/settings' do
	@title = "Game Settings"
  $player_one_marker = params[:player_one_marker]
	$player_two_marker = params[:player_two_marker]
	if params[:first_player].eql?("player_one_marker")
		first_player = $player_one_marker
	else
		first_player = $player_two_marker
	end
	$game = TicTacToeRules.new(TicTacToeBoard.new, first_player: first_player , player_one_marker: $player_one_marker, player_two_marker: $player_two_marker)
	$board = $game.get_board
	$board_array = $game.get_array_board
	redirect '/play_game'
end

get '/play_game' do
	@title = "Game"
  $board = $game.get_board
	$board_array = $game.get_array_board
	erb :play_game
end

post '/play_game' do
	@title = "Game"
	location_chosen = params[:spot].to_i
	if $game.game_over?
		redirect '/end_game'
		return nil
	else
		$game.game_turn(location_chosen)
		$board = $game.get_board
		$board_array = $game.get_array_board
	end
	erb :play_game
end

get '/end_game' do
	@title = "Game Over"
	erb :end_game
end

not_found do
	@title = "Not found!"
  erb :not_found
end
