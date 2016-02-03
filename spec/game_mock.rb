class GameMock
  attr_reader :player_one_marker, :player_two_marker, :player_turn, :id, :player_one_ai, :player_two_ai,\
              :game_board, :active, :end_game_state
  attr_writer :player_one_marker, :player_two_marker, :player_turn, :id, :player_one_ai, :player_two_ai,\
              :game_board, :active, :end_game_state

  def initialize
    @id = 0
    @player_one_marker = "X"
    @player_two_marker = "O"
    @player_turn = "X"
    @player_one_ai = false
    @player_two_ai = false
    @game_board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @active = true
    @end_game_state = nil
  end

  def self.get
  end

  def self.all
  end

  def save
  end

end
