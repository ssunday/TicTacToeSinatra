class TicTacToeBoard

  attr_reader :board
  
  def initialize(boards = {})
    @board = boards.fetch(:board, ["0", "1", "2", "3", "4", "5", "6", "7", "8"])
  end

  def set_board_location(location, marker)
    board[location] = marker
  end

  def get_board_location(spot)
    board[spot]
  end

  def location_valid_to_mark?(args = {})
    board[args[:location]] != args[:player_one_marker] && board[args[:location]] != args[:player_two_marker]
  end

  def won?
    [board[0], board[1], board[2]].uniq.length == 1 ||
    [board[3], board[4], board[5]].uniq.length == 1 ||
    [board[6], board[7], board[8]].uniq.length == 1 ||
    [board[0], board[3], board[6]].uniq.length == 1 ||
    [board[1], board[4], board[7]].uniq.length == 1 ||
    [board[2], board[5], board[8]].uniq.length == 1 ||
    [board[0], board[4], board[8]].uniq.length == 1 ||
    [board[2], board[4], board[6]].uniq.length == 1
  end

  def tie?(player_markers = {})
    board.all? { |spot| spot == player_markers[:player_one_marker] || spot == player_markers[:player_two_marker]} && won? == false
  end

end
