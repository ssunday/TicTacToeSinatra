require_relative 'tic_tac_toe_board.rb'
require_relative 'tic_tac_toe_rules.rb'
require_relative 'tic_tac_toe_ai.rb'

module GameUtilityFunctions

  def set_up_game(params = {})
    game = params[:game]
    game.active = true
    assign_markers(game, params[:player_one_marker], params[:player_two_marker])
    assign_initial_player_turn(game, params[:first_player])
    assign_player_ai(game, params[:player_one_type], params[:player_two_type])
    assign_new_game_board(game)
  end

  def create_new_game_rules(game)
<<<<<<< HEAD
    board = de_serialize_board(game.game_board)
    current_board = TicTacToeBoard.new(board: board)
=======
<<<<<<< Updated upstream
    board = de_serialize_board(game.game_board)
    current_board = TicTacToeBoard.new(board: board)
=======
		current_board = TicTacToeBoard.new(board: Array.new(game.game_board))
>>>>>>> Stashed changes
>>>>>>> origin/master
		TicTacToeRules.new(current_board, first_player: game.player_turn, player_one: game.player_one_marker, player_two: game.player_two_marker)
	end

  def get_location_chosen(game, spot)
<<<<<<< HEAD
    board = de_serialize_board(game.game_board)
    current_board = TicTacToeBoard.new(board: board)
=======
<<<<<<< Updated upstream
    board = de_serialize_board(game.game_board)
    current_board = TicTacToeBoard.new(board: board)
=======
    current_board = TicTacToeBoard.new(board: Array.new(game.game_board))
>>>>>>> Stashed changes
>>>>>>> origin/master
    if game.player_turn.eql?(game.player_one_marker) && game.player_one_ai
      get_ai_move(game.player_one_marker, game.player_two_marker, current_board)
  	elsif game.player_turn.eql?(game.player_two_marker) && game.player_two_ai
      get_ai_move(game.player_two_marker, game.player_one_marker, current_board)
  	else
  		spot.to_i
  	end
  end

  def game_turn(game, game_rules, spot)
  	location_chosen = get_location_chosen(game, spot)
    game_rules.game_turn(location_chosen)
<<<<<<< HEAD
  	game.game_board = serialize_board(game_rules.get_array_board)
=======
<<<<<<< Updated upstream
  	game.game_board = serialize_board(game_rules.get_array_board)
=======
  	game.game_board = game_rules.get_array_board
>>>>>>> Stashed changes
>>>>>>> origin/master
  	game.player_turn = game_rules.player_turn
    if game_rules.game_over?
      assign_end_game_state(game, game_rules)
      game.active = false
    end
  end

  def assign_end_game_state(game, game_rules)
    if game_rules.player_one_won?
  			game.end_game_state = "Player One Won"
    elsif game_rules.player_two_won?
  			game.end_game_state = "Player Two Won"
    else
  			game.end_game_state = "Tied"
    end
  end

  def de_serialize_board(board)
    board.split(" ")
  end

  def serialize_board(board)
    board.join(" ")
  end

  private

  def assign_markers(game, player_one_marker, player_two_marker)
    game.player_one_marker = player_one_marker
    game.player_two_marker = player_two_marker
  end

  def assign_player_ai(game, player_one_type, player_two_type)
    assign_player_one_ai(game, player_one_type)
    assign_player_two_ai(game, player_two_type)
  end

  def assign_player_one_ai(game, player_one_type)
    if player_one_type.eql?("AI")
			game.player_one_ai = true
		else
			game.player_one_ai = false
		end
  end

  def assign_player_two_ai(game, player_two_type)
    if player_two_type.eql?("AI")
			game.player_two_ai = true
		else
			game.player_two_ai = false
		end
  end

  def assign_initial_player_turn(game, first_player)
    if first_player.eql?("player_one_marker")
			game.player_turn = game.player_one_marker
		else
			game.player_turn = game.player_two_marker
		end
  end

  def assign_new_game_board(game)
<<<<<<< HEAD
    board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
		game.game_board = serialize_board(board)
=======
<<<<<<< Updated upstream
    board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
		game.game_board = serialize_board(board)
=======
		game.game_board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
>>>>>>> Stashed changes
>>>>>>> origin/master
  end

  def get_ai_move(ai_player_marker, other_player_marker, current_board)
    ai_player = TicTacToeAi.new(ai_marker: ai_player_marker, other_player_marker: other_player_marker)
    ai_player.move(current_board, ai_player_marker)
  end

end
