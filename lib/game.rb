require 'data_mapper'

class Game
  include DataMapper::Resource
  property :id, Serial
  property :player_one_marker, String
  property :player_two_marker, String
  property :player_turn, String
	property :player_one_ai, Boolean
	property :player_two_ai, Boolean
  property :game_board, Object
  property :previous_or_active, String
  property :end_game_state, String, :required => false
end
