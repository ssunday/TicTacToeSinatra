
class PreviousGamesPage

  def initialize(previous_games, unfinished_games)
    @previous_games = previous_games
    @unfinished_games = unfinished_games
  end

  def show_unfinished_games
    boards = ""
    @unfinished_games.each do |unfinished_game|
      boards += show_markers_and_turns(unfinished_game)
      boards += show_board(unfinished_game)
      boards += add_resume_button(unfinished_game)
    end
    boards
  end

  def show_previous_games
    string_to_show = ""
    @previous_games.each do |previous_game|
      string_to_show += show_end_state(previous_game)
      string_to_show += show_board(previous_game)
    end
    string_to_show
  end

  private

  def add_resume_button(game)
    "<form action='/play_game' method='get'>
    <button name='game_id' type='submit' value='#{game.id}'>Resume Game</button>
    </form>
    <br>"
  end

  def show_end_state(game)
    "
    <br>
    <h2> #{game.end_game_state} </h2>
    <br>
    "
  end

  def show_markers_and_turns(game)
    " <h2> Current player: #{game.player_turn } </h2>
      <h2> Player One Marker: #{game.player_one_marker } </h2>
      <h2> Player Two Marker: #{game.player_two_marker } </h2>
      <br>
      "
  end

  def show_board(game)
<<<<<<< Updated upstream
    board = game.game_board.split(' ')
=======
>>>>>>> Stashed changes
    "
    <table>
    <tr>
      <td style='padding: 0 15px 0 15px;'>
      #{game.game_board[0]}
      </td>
      <td style='padding: 0 15px 0 15px;'>
      #{game.game_board[1]}
      </td>
      <td style='padding: 0 15px 0 15px;'>
      #{game.game_board[2]}
      </td>
    </tr>
    <tr>
      <td style='padding: 0 15px 0 15px;'>
      #{game.game_board[3]}
      </td>
      <td style='padding: 0 15px 0 15px;'>
      #{game.game_board[4]}
      </td>
      <td style='padding: 0 15px 0 15px;'>
      #{game.game_board[5]}
      </td>
    </tr>
    <tr>
      <td style='padding: 0 15px 0 15px;'>
      #{game.game_board[6]}
      </td>
      <td style= 'padding: 0 15px 0 15px';>
      #{game.game_board[7]}
      </td>
      <td style='padding: 0 15px 0 15px;'>
      #{game.game_board[8]}
      </td>
    </tr>
    </table>
    <br>
    "
  end

end
