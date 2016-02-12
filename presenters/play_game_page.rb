class PlayGamePage

  def initialize(game,board)
    @game = game
<<<<<<< HEAD
    @game_board = board
=======
<<<<<<< Updated upstream
    @game_board = board
=======
>>>>>>> Stashed changes
>>>>>>> origin/master
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
    board += start_form
    for i in 0..8 do
      board += begin_table_row(i)
      board += begin_cell
      board += show_cell_value_or_input(i)
      board += end_cell
      board += end_table_row(i)
    end
    board += add_submit_button
    board
  end

  private

  def start_form
    "<table><form action='/play_game' method='post'>"
  end

  def begin_table_row(cell_number)
    if cell_number % 3 == 0 || cell_number == 0
      "<tr>"
    else
      ""
    end
  end

  def begin_cell
    "<td style='padding:0 15px 0 15px;'>"
  end

  def show_cell_value_or_input(cell_number)
    if @game_board[cell_number] != @game.player_one_marker && @game_board[cell_number] != @game.player_two_marker && human_player_turn?
      "<input type='radio' name='spot' value='#{cell_number}' checked>"
    else
      "#{@game_board[cell_number]}"
    end
  end

  def end_cell
    "</td>"
  end

  def end_table_row(cell_number)
    if cell_number == 2 || cell_number == 5 || cell_number == 8
      "</tr>"
    else
      ""
    end
  end

  def add_submit_button
    "</table>
      <br>
      <button name='game_id' type='submit' value='#{@game.id}'>Next Turn</button>
    </form>"
  end

end
