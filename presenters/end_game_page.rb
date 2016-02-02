class EndGamePage

  def initialize(game_rules)
    @game_rules = game_rules
  end

  def show_end_result
    if @game_rules.player_one_won?
        "<h1> Player One has Won! </h1>"
    elsif @game_rules.player_two_won?
        "<h1> Player Two has Won! </h1>"
    else
        "<h1> The Game is Tied! </h1>"
    end
  end
  
end
