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

  def show_active_board
    board = ""
    board += "<table>
    <form action='/play_game' method='post'>"
    for i in 0..8 do
      if i % 3 == 0 || i == 0
        board += "<tr>"
      end
      board += "<td style='padding:0 15px 0 15px;'>"
      if @game.game_board[i] != @game.player_one_marker && @game.game_board[i] != @game.player_two_marker && human_player_turn?
        board += "<input type='radio' name='spot' value='#{i}' checked>"
      else
        board += "#{@game.game_board[i]}"
      end
      board += "</td>"
      if i == 2 || i == 5 || i == 8
        board += "</tr>"
      end
    end
    board += "</table>
      <br>
      <button name='game_id' type='submit' value='#{@game.id}'>Next Turn</button>
    </form>"
  end

end
