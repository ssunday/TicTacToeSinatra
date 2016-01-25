require 'sinatra'
require_relative 'assets/tic_tac_toe_board.rb'
require_relative 'assets/tic_tac_toe_rules.rb'
require_relative 'assets/tic_tac_toe_ai.rb'
require 'sinatra/formkeeper'

use Rack::Session::Cookie, :key => 'rack.session', :path => '/', :secret => 'tic-tac-toe'

get '/' do
	@title = 'Home'
	session.clear
	erb :index
end

get '/settings' do
  @title = "Game Settings"
  erb :settings
end

post '/settings' do
	@title = "Game Settings"

	session["player_one_marker"] = params[:player_one_marker]
	session["player_two_marker"] = params[:player_two_marker]

	form do
		field :player_one_marker, :present => true, :length => 1, :int => false
		field :player_two_marker, :present => true, :length => 1, :int => false
	end

	if form.failed? || (session["player_one_marker"].eql?(session["player_two_marker"]))
    erb :settings
  else
		if params[:first_player].eql?("player_one_marker")
			first_player = params[:player_one_marker]
		else
			first_player = params[:player_two_marker]
		end

		if params[:player_one_type].eql?("AI")
			session["player_one_ai"] = TicTacToeAi.new(ai_marker: session["player_one_marker"], other_player_marker: session["player_two_marker"])
		else
			session["player_one_ai"] = nil
		end
		if params[:player_two_type].eql?("AI")
			session["player_two_ai"] = TicTacToeAi.new(ai_marker: session["player_two_marker"], other_player_marker: session["player_one_marker"])
		else
			session["player_two_ai"] = nil
		end
		session["game"] = TicTacToeRules.new(TicTacToeBoard.new, first_player: first_player , player_one: session["player_one_marker"], player_two: session["player_two_marker"])
		redirect '/play_game'
  end
end

get '/play_game' do
	@title = "Game"
	if session["game"].game_over?
		redirect '/end_game'
		return nil
	end
	erb :play_game
end

post '/play_game' do
	@title = "Game"
	current_board = TicTacToeBoard.new(board: Array.new(session["game"].get_array_board))
	if session["game"].player_turn.eql?(session["player_one_marker"]) && session["player_one_ai"] != nil
		location_chosen = session["player_one_ai"].move(current_board, session["player_one_marker"])
	elsif session["game"].player_turn.eql?(session["player_two_marker"]) && session["player_two_ai"] != nil
		location_chosen = session["player_two_ai"].move(current_board, session["player_two_marker"])
	else
		location_chosen = params[:spot].to_i
	end
	session["game"].game_turn(location_chosen)
	redirect to('/play_game')
end

get '/end_game' do
	@title = "Game Over"
	erb :end_game
end

not_found do
	@title = "Not found!"
  erb :not_found
end
