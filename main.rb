require 'sinatra'
require 'sinatra/formkeeper'
require 'data_mapper'
require_relative 'lib/tic_tac_toe_rules.rb'
require_relative 'lib/tic_tac_toe_ai.rb'
require_relative 'lib/game.rb'
require_relative 'lib/game_utility_functions.rb'

include GameUtilityFunctions

DataMapper.setup(:default, 'postgres://xeuqunygyaxxxv:f7RVOavZHHpP_SFrunnlEN1ErQ@ec2-54-225-195-249.compute-1.amazonaws.com:5432/do4clntk7ijkk')
DataMapper.auto_upgrade!
DataMapper.finalize

get '/' do
	@title = 'Home'
	erb :index
end

get '/settings' do
  @title = "Game Settings"
  @duplicated = false
  erb :settings
end

post '/settings' do
	@title = "Game Settings"

	form do
		field :player_one_marker, :present => true, :length => 1, :int => false
		field :player_two_marker, :present => true, :length => 1, :int => false
	end

  @duplicated = params[:player_one_marker].eql?(params[:player_two_marker])

	if form.failed? || @duplicated
    @game = Game.last(:active => true)
    erb :settings
  else
    @game = Game.new
		@game = set_up_game(game: @game, player_one_marker: params[:player_one_marker], \
		player_two_marker: params[:player_two_marker],\
		first_player: params[:first_player], player_one_type: params[:player_one_type], player_two_type: params[:player_two_type])
		@game.save
		@game_rules = create_new_game_rules(@game)
		erb :play_game
  end
end

get '/play_game' do
	@title = "Play Game"
  @game = Game.get(params[:game_id])
	@game_rules = create_new_game_rules(@game)
	erb :play_game
end

post '/play_game' do
	@title = "Play Game"
  @game = Game.get(params[:game_id])
	@game_rules = create_new_game_rules(@game)
	location_chosen = get_location_chosen(@game, params[:spot])
  @game_rules.game_turn(location_chosen)
	@game.game_board = @game_rules.get_array_board
	@game.player_turn = @game_rules.player_turn
  @game.save
  if @game_rules.game_over?
    @title = "Game Over"
    @game.active = false
    @game.save
    erb :end_game
  else
    erb :play_game
  end
end

get '/previous_games' do
  @title = "Previous Games"
  @unfinished_games = Game.all(:active => true)
  @previous_games = Game.all(:active => false)
  erb :previous_games
end

not_found do
	@title = "Not found!"
  erb :not_found
end
