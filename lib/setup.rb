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
    game.save
    return game
  end

end
