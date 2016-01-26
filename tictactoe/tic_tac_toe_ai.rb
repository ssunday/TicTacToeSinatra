class TicTacToeAi

  attr_reader :ai_marker, :other_player_marker

  def initialize(markers = {})
    @ai_marker = markers[:ai_marker]
    @other_player_marker = markers[:other_player_marker]
  end

  def move(board, current_player, depth = 0, best_score={})

    if game_over?(board)
      return score(board, current_player, depth)
    end

    available_spaces = get_possible_moves(board)
    available_spaces.each do |space|
      board.set_board_location(space.to_i, current_player)
      next_player = switch_turn(current_player)
      best_score[space.to_i] = -1 * move(board, next_player, depth + 1, {})
      board.set_board_location(space.to_i, space)
    end

    best_move = best_score.max_by { |space, score| score }[0]
    highest_minimax_score = best_score.max_by { |space, score| score }[1]

    if depth == 0
      return best_move.to_i
    elsif depth > 0
      return highest_minimax_score
    end

  end

  def score(board, current_player, depth)
    if ai_won?(board, current_player)
        return 100 - depth
    elsif other_player_won?(board, current_player)
        return depth - 100
    elsif tied?(board)
        return 0
    end
  end

  private

  def get_possible_moves(board)
    possible_spaces = []
    board.board.each do |space|
      if board.location_valid_to_mark?(location: space.to_i, player_one_marker: ai_marker, player_two_marker: other_player_marker)
        possible_spaces << space
      end
    end
    possible_spaces
  end

  def switch_turn(current_player)
    if current_player.eql?(ai_marker)
      other_player_marker
    else
      ai_marker
    end
  end

  def other_player_won?(board, current_player)
    current_player.eql?(ai_marker) && board.won?
  end

  def ai_won?(board, current_player)
    current_player.eql?(other_player_marker) && board.won?
  end

  def game_over?(board)
    board.won? || tied?(board)
  end

  def tied?(board)
    board.tie?(player_one_marker: ai_marker, player_two_marker: other_player_marker)
  end


end
