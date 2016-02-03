require 'sinatra'
require 'data_mapper'
require_relative 'lib/game.rb'
require_relative 'lib/game_utility_functions.rb'
require_relative 'presenters/play_game_page.rb'
require_relative 'presenters/previous_games_page.rb'
require_relative 'presenters/end_game_page.rb'

include GameUtilityFunctions

configure do
	DataMapper.setup(:default, 'postgres://xeuqunygyaxxxv:f7RVOavZHHpP_SFrunnlEN1ErQ@ec2-54-225-195-249.compute-1.amazonaws.com:5432/do4clntk7ijkk')
	DataMapper.auto_upgrade!
	DataMapper.finalize
end

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
	  game = Game.new
		game = set_up_game(game: game, player_one_marker: params[:player_one_marker], \
		player_two_marker: params[:player_two_marker],\
		first_player: params[:first_player], player_one_type: params[:player_one_type], player_two_type: params[:player_two_type])
		game.save
		redirect "/play_game?game_id=#{game.id}"
	end
end

get '/play_game' do
	@title = "Play Game"
  game = Game.get(params[:game_id])
	@view = PlayGamePage.new(game)
	erb :play_game
end

post '/play_game' do
	@title = "Play Game"
  game = Game.get(params[:game_id])
	game_rules = create_new_game_rules(game)
	game = game_turn(game, game_rules, params[:spot])
	game.save
  if game.active
		@view = PlayGamePage.new(game)
    erb :play_game
  else
		game_rules = create_new_game_rules(game)
		game = assign_end_game_state(game, game_rules)
		game.save
		@view = EndGamePage.new(game)
    erb :end_game
  end
end

get '/previous_games' do
  @title = "Previous Games"
	@view_previous = PreviousGamesPage.new(Game.all(:active => false), Game.all(:active => true))
  erb :previous_games
end

not_found do
	@title = "Not Found!"
  erb :not_found
end
