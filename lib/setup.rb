require_relative 'tic_tac_toe_board.rb'
require_relative 'tic_tac_toe_rules.rb'
require_relative 'tic_tac_toe_ai.rb'
module GameSetup

  def set_up_game(params = {})
    game = params[:game]
    game.active = true

    game.player_one_marker = params[:player_one_marker]
    game.player_two_marker = params[:player_two_marker]

		if params[:first_player].eql?("player_one_marker")
			game.player_turn = params[:player_one_marker]
		else
			game.player_turn = params[:player_two_marker]
		end

		if params[:player_one_type].eql?("AI")
			game.player_one_ai = true
		else
			game.player_one_ai = false
		end

		if params[:player_two_type].eql?("AI")
			game.player_two_ai = true
		else
			game.player_two_ai = false
		end
    game_board = TicTacToeBoard.new
		game.game_board = game_board.board
    game.save
    game
  end

  def create_new_game_rules(game)
		current_board = TicTacToeBoard.new(board: Array.new(game.game_board))
		TicTacToeRules.new(current_board, first_player: game.player_turn, player_one: game.player_one_marker, player_two: game.player_two_marker)
	end

end
