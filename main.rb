require 'sinatra'
require_relative 'tictactoe/tic_tac_toe_board.rb'
require_relative 'tictactoe/tic_tac_toe_rules.rb'
require_relative 'tictactoe/tic_tac_toe_ai.rb'
require 'sinatra/formkeeper'
require 'data_mapper'

DataMapper.setup(:default, 'postgres://xeuqunygyaxxxv:f7RVOavZHHpP_SFrunnlEN1ErQ@ec2-54-225-195-249.compute-1.amazonaws.com:5432/do4clntk7ijkk')

class Game
  include DataMapper::Resource
  property :general_id, String, :key => true
  property :player_one_marker, String
  property :player_two_marker, String
	property :player_one_ai, Object, :required => false
	property :player_two_ai, Object, :required => false
	property :game_rules, Object
end

DataMapper.auto_upgrade!
DataMapper.finalize
#Below code was found on Stack Overflow to make it so an Object property properly updates.
#http://stackoverflow.com/questions/18698331/updating-object-property-in-datamappers
module DataMapper
  module Resource
    def make_dirty(*attributes)
      if attributes.empty?
        return
      end
      unless self.clean?
        self.save
      end
      dirty_state = DataMapper::Resource::PersistenceState::Dirty.new(self)
      attributes.each do |attribute|
        property = self.class.properties[attribute]
        dirty_state.original_attributes[property] = nil
        self.persistence_state = dirty_state
      end
    end
  end
end

get '/' do
	@title = 'Home'
  game = Game.last(:general_id => "Active Game")
  if game != nil
    game.destroy
  end
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

  game = Game.last(:general_id => "Active Game")
  if game != nil
    game.destroy
  end

	if form.failed? || @duplicated
    @game = Game.last(:general_id => "Active Game")
    erb :settings
  else
    game = Game.new
    game.general_id = "Active Game"

    game.player_one_marker = params[:player_one_marker]
    game.player_two_marker = params[:player_two_marker]

		if params[:first_player].eql?("player_one_marker")
			first_player = params[:player_one_marker]
		else
			first_player = params[:player_two_marker]
		end

		if params[:player_one_type].eql?("AI")
			game.player_one_ai = TicTacToeAi.new(ai_marker: params[:player_one_marker], other_player_marker: params[:player_two_marker])
		else
			game.player_one_ai = nil
		end

		if params[:player_two_type].eql?("AI")
			game.player_two_ai = TicTacToeAi.new(ai_marker: params[:player_two_marker], other_player_marker: params[:player_one_marker])
		else
			game.player_two_ai = nil
		end

		game.game_rules = TicTacToeRules.new(TicTacToeBoard.new, first_player: first_player , player_one: params[:player_one_marker], player_two: params[:player_two_marker])
    game.save
		redirect '/play_game'
  end
end

get '/play_game' do
	@title = "Game"
  @game = Game.last(:general_id => "Active Game")
	if @game.game_rules.game_over?
		redirect '/end_game'
		return nil
	end
	erb :play_game
end

post '/play_game' do
	@title = "Play Game"
  @game = Game.last(:general_id => "Active Game")
	current_board = TicTacToeBoard.new(board: Array.new(@game.game_rules.get_array_board.dup))
	if @game.game_rules.player_turn.eql?(@game.player_one_marker) && @game.player_one_ai != nil
		location_chosen = @game.player_one_ai.move(current_board, @game.player_one_marker)
	elsif @game.game_rules.player_turn.eql?(@game.player_two_marker) && @game.player_two_ai != nil
		location_chosen = @game.player_two_ai.move(current_board, @game.player_two_marker)
	else
		if params[:spot] == nil
			redirect to('/play_game')
		else
			location_chosen = params[:spot].to_i
		end
	end
  @game.game_rules.game_turn(location_chosen)
  @game.make_dirty(:game_rules)
  @game.save
	redirect to('/play_game')
end

get '/end_game' do
	@title = "Game Over"
  @game = Game.last(:general_id => "Active Game")
	erb :end_game
end

not_found do
	@title = "Not found!"
  erb :not_found
end
