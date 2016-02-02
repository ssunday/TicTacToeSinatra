require_relative 'tic_tac_toe_board.rb'
require_relative 'tic_tac_toe_rules.rb'
require_relative 'tic_tac_toe_ai.rb'

module GameUtilityFunctions

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

  def get_location_chosen(game, spot)
    current_board = TicTacToeBoard.new(board: Array.new(game.game_board))
    if game.player_turn.eql?(game.player_one_marker) && game.player_one_ai
  		player_one_ai = TicTacToeAi.new(ai_marker: game.player_one_marker, other_player_marker: game.player_two_marker)
  		player_one_ai.move(current_board, game.player_one_marker)
  	elsif game.player_turn.eql?(game.player_two_marker) && game.player_two_ai
  		player_two_ai = TicTacToeAi.new(ai_marker: game.player_two_marker, other_player_marker: game.player_one_marker)
  		player_two_ai.move(current_board, game.player_two_marker)
  	else
  		spot.to_i
  	end
  end

  def game_turn(game, game_rules, spot)
  	location_chosen = get_location_chosen(game, spot)
    game_rules.game_turn(location_chosen)
  	game.game_board = game_rules.get_array_board
  	game.player_turn = game_rules.player_turn
    if game_rules.game_over?
      game.active = false
    end
    game.save
    game
  end

  def assign_end_game_state(game, game_rules)
    if game_rules.player_one_won?
  			game.end_game_state = "Player One Won"
    elsif game_rules.player_two_won?
  			game.end_game_state = "Player Two Won"
    else
  			game.end_game_state = "Tied"
    end
  	game.save
    game
  end

end
