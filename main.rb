require 'sinatra'
require_relative 'lib/game_model_wrapper.rb'
require_relative 'presenters/play_game_page.rb'
require_relative 'presenters/previous_games_page.rb'
require_relative 'presenters/end_game_page.rb'

include GameModelWrapper

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
	if params[:player_one_marker].eql?(params[:player_two_marker])
    erb :settings
	else
		game = create_game(player_one_marker: params[:player_one_marker], \
		player_two_marker: params[:player_two_marker],\
		first_player: params[:first_player], player_one_type: params[:player_one_type], player_two_type: params[:player_two_type])
		redirect "/play_game?game_id=#{game.id}"
	end
end

get '/play_game' do
	@title = "Play Game"
	game = get_game_given_id(params[:game_id])
	@view = PlayGamePage.new(game)
	erb :play_game
end

post '/play_game' do
	@title = "Play Game"
	game = get_game_given_id(params[:game_id])
	do_game_turn(game, params[:spot])
  if active?(game)
		@view = PlayGamePage.new(game)
    erb :play_game
  else
		@view = EndGamePage.new(game)
    erb :end_game
  end
end

get '/previous_games' do
  @title = "Previous Games"
	@view_previous = PreviousGamesPage.new(get_finished_games, get_unfinished_games)
  erb :previous_games
end

not_found do
	@title = "Not Found!"
  erb :not_found
end
