class TicTacToeRules
  attr_reader :player_turn, :player_one_marker, :player_two_marker

  def initialize(initial_board, player_info = {}) #first_player, player_one, player_two)
    @player_turn = player_info[:first_player]
    @player_one_marker = player_info[:player_one]
    @player_two_marker = player_info[:player_two]
    @board = initial_board
  end

  def game_turn(spot)
    @board.set_board_location(spot, player_turn)
    switch_turn
  end

  def get_board
    @board
  end

  def get_array_board
    @board.board
  end

  def switch_turn
    if player_turn.eql?(player_two_marker)
      @player_turn = @player_one_marker
    else
      @player_turn = @player_two_marker
    end
  end

  def game_over?
    @board.won? || tied?
  end

  def player_one_won?
    player_turn.eql?(player_two_marker) && @board.won?
  end

  def player_two_won?
    player_turn.eql?(player_one_marker) && @board.won?
  end

  def tied?
    @board.tie?(player_one_marker: player_one_marker, player_two_marker: player_two_marker)
  end

end
