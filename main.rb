require 'sinatra'
require_relative 'tictactoe/tic_tac_toe_board.rb'
require_relative 'tictactoe/tic_tac_toe_rules.rb'
require_relative 'tictactoe/tic_tac_toe_ai.rb'
require_relative 'lib/game.rb'
require 'sinatra/formkeeper'
require 'data_mapper'

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
    @game = Game.last(:previous_or_active => "Active")
    erb :settings
  else
    @game = Game.new
    @game.previous_or_active = "Active"

    @game.player_one_marker = params[:player_one_marker]
    @game.player_two_marker = params[:player_two_marker]

		if params[:first_player].eql?("player_one_marker")
			@game.player_turn = params[:player_one_marker]
		else
			@game.player_turn = params[:player_two_marker]
		end

		if params[:player_one_type].eql?("AI")
			@game.player_one_ai = true
		else
			@game.player_one_ai = false
		end

		if params[:player_two_type].eql?("AI")
			@game.player_two_ai = true
		else
			@game.player_two_ai = false
		end
		game_board = TicTacToeBoard.new
		@game.game_board = game_board.board
		@game_rules = TicTacToeRules.new(game_board, first_player: @game.player_turn , player_one: params[:player_one_marker], player_two: params[:player_two_marker])
    @game.save
		erb :play_game
  end
end

get '/play_game' do
	@title = "Play Game"
  @game = Game.get(params[:id])
	current_board = TicTacToeBoard.new(board: Array.new(@game.game_board))
	@game_rules = TicTacToeRules.new(current_board, first_player: @game.player_turn, player_one: @game.player_one_marker, player_two: @game.player_two_marker)
	erb :play_game
end

post '/play_game' do
	@title = "Play Game"
  @game = Game.get(params[:game_id])
	current_board = TicTacToeBoard.new(board: Array.new(@game.game_board))
	@game_rules = TicTacToeRules.new(current_board, first_player: @game.player_turn, player_one: @game.player_one_marker, player_two: @game.player_two_marker)
	if @game.player_turn.eql?(@game.player_one_marker) && @game.player_one_ai
		player_one_ai = TicTacToeAi.new(ai_marker: @game.player_one_marker, other_player_marker: @game.player_two_marker)
		location_chosen = player_one_ai.move(current_board, @game.player_one_marker)
	elsif @game.player_turn.eql?(@game.player_two_marker) && @game.player_two_ai
		player_two_ai = TicTacToeAi.new(ai_marker: @game.player_two_marker, other_player_marker: @game.player_one_marker)
		location_chosen = player_two_ai.move(current_board, @game.player_two_marker)
	else
		location_chosen = params[:spot].to_i
	end
  @game_rules.game_turn(location_chosen)
	@game.game_board = @game_rules.get_array_board
	@game.player_turn = @game_rules.player_turn
  @game.save
  if @game_rules.game_over?
    @title = "Game Over"
    @game.previous_or_active = "Previous"
    @game.save
    erb :end_game
  else
    erb :play_game
  end
end

get '/previous_games' do
  @title = "Previous Games"
  @unfinished_games = Game.all(:previous_or_active => "Active")
  @previous_games = Game.all(:previous_or_active => "Previous")
  erb :previous_games
end

not_found do
	@title = "Not found!"
  erb :not_found
end
