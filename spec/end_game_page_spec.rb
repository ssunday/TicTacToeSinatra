require File.expand_path '../../presenters/end_game_page.rb', __FILE__
require File.expand_path '../../lib/game.rb', __FILE__

describe EndGamePage do

  before do
    @game = Game.new
    @player_one_marker = "X"
    @player_two_marker = "O"
    set_up_game(game: @game, player_one_type: "AI", player_two_type: "Human", \
    player_one_marker: @player_one_marker, \
    player_two_marker: @player_two_marker, \
    first_player: "player_one_marker"
    )
    @game.save
  end

  it "shows player one win when they have won" do
    @game.end_game_state = "Player One Won"
    @view = EndGamePage.new(@game)
    expect(@view.show_end_result).to eq "<h1>Player One Won!</h1>"
  end

  it "shows player two win when they have won" do
    @game.end_game_state = "Player Two Won"
    @view = EndGamePage.new(@game)
    expect(@view.show_end_result).to eq "<h1>Player Two Won!</h1>"
  end

  it "shows tied when tied" do
    @game.end_game_state = "Tied"
    @view = EndGamePage.new(@game)
    expect(@view.show_end_result).to eq "<h1>Tied!</h1>"
  end

end
