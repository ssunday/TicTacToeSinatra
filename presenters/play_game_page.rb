class PlayGamePage

  def initialize(game)
    @game = game
  end

  def human_player_turn?
    if (@game.player_one_ai && @game.player_turn.eql?(@game.player_one_marker)) \
      || (@game.player_two_ai && @game.player_turn.eql?(@game.player_two_marker))
      false
    else
      true
    end
  end

  def report_whether_AI_or_player_turn
    if human_player_turn?
      "Player Turn"
    else
      "AI Turn"
    end
  end

  def report_player_turn_and_marker
    if @game.player_turn.eql?(@game.player_one_marker)
      "It is Player One's Turn. Marker: #{@game.player_one_marker}"
    else
      "It is Player Two's Turn. Marker: #{@game.player_two_marker}"
    end
  end

end
