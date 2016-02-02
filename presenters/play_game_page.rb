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
      "<h1>Player Turn</h1>"
    else
      "<h1>AI Turn</h1>"
    end
  end

  def report_player_turn_and_marker
    if @game.player_turn.eql?(@game.player_one_marker)
      "<h1>It is Player One's Turn. Marker: #{@game.player_one_marker}</h1>"
    else
      "<h1>It is Player Two's Turn. Marker: #{@game.player_two_marker}</h1>"
    end
  end

end
