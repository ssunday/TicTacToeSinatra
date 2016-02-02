class PreviousGamesPage
  
  def initialize(previous_games, unfinished_games)
    @previous_games = previous_games
    @unfinished_games = unfinished_games
  end

  def show_unfinished_games
    boards = ""
    @unfinished_games.each do |unfinished_game|
      boards += "
        <br>
        <form action='/play_game' method='get'>
        <button name='game_id' type='submit' value='#{unfinished_game.id}'>Resume Game</button>
        </form>
        <h2> Player One Marker: #{unfinished_game.player_one_marker } </h2>
        <h2> Player Two Marker: #{unfinished_game.player_two_marker } </h2>
        <br>
      <table>
        <tr>
          <td style='padding:0 15px 0 15px;'>
          #{unfinished_game.game_board[0] }
          </td>
          <td style='padding:0 15px 0 15px;'>
          #{unfinished_game.game_board[1] }
          </td>
          <td style='padding:0 15px 0 15px;'>
          #{unfinished_game.game_board[2] }
          </td>
        </tr>
        <tr>
          <td style='padding:0 15px 0 15px;'>
          #{unfinished_game.game_board[3] }
          </td>
          <td style='padding:0 15px 0 15px;'>
          #{unfinished_game.game_board[4] }
          </td>
          <td style='padding:0 15px 0 15px;'>
          #{unfinished_game.game_board[5] }
          </td>
        </tr>
        <tr>
          <td style='padding:0 15px 0 15px;'>
          #{unfinished_game.game_board[6] }
          </td>
          <td style='padding:0 15px 0 15px;'>
          #{unfinished_game.game_board[7] }
          </td>
          <td style='padding:0 15px 0 15px;'>
          #{unfinished_game.game_board[8]}
          </td>
        </tr>
      </table>
      "
      end
      boards
    end

    def show_previous_games
      string_to_show = ""
      @previous_games.each do |previous_game|
        string_to_show += "
        <br>
        <h2> #{previous_game.end_game_state} </h2>
        <br>
        <table>
        <tr>
          <td style='padding: 0 15px 0 15px;'>
          #{previous_game.game_board[0]}
          </td>
          <td style='padding: 0 15px 0 15px;'>
          #{previous_game.game_board[1]}
          </td>
          <td style='padding: 0 15px 0 15px;'>
          #{previous_game.game_board[2]}
          </td>
        </tr>
        <tr>
          <td style='padding: 0 15px 0 15px;'>
          #{previous_game.game_board[3]}
          </td>
          <td style='padding: 0 15px 0 15px;'>
          #{previous_game.game_board[4]}
          </td>
          <td style='padding: 0 15px 0 15px;'>
          #{previous_game.game_board[5]}
          </td>
        </tr>
        <tr>
          <td style='padding: 0 15px 0 15px;'>
          #{previous_game.game_board[6]}
          </td>
          <td style= 'padding: 0 15px 0 15px';>
          #{previous_game.game_board[7]}
          </td>
          <td style='padding: 0 15px 0 15px;'>
          #{previous_game.game_board[8]}
          </td>
        </tr>
        </table>
        "
      end
    string_to_show
  end

end
