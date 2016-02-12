class EndGamePage

  def initialize(game)
    @game = game
  end

  def show_end_result
    "<h1>#{@game.end_game_state}!</h1>"
  end

end
