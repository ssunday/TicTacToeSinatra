require 'data_mapper'

class Game
  include DataMapper::Resource
  property :id, Serial
  property :player_one_marker, String
  property :player_two_marker, String
  property :player_turn, String
	property :player_one_ai, Boolean
	property :player_two_ai, Boolean
<<<<<<< HEAD
  property :game_board, String
=======
<<<<<<< Updated upstream
  property :game_board, String
=======
  property :game_board, Object
>>>>>>> Stashed changes
>>>>>>> origin/master
  property :active, Boolean
  property :end_game_state, String, :required => false
end
