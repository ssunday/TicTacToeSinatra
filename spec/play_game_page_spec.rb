require File.expand_path '../../presenters/play_game_page.rb', __FILE__
require File.expand_path '../../lib/game.rb', __FILE__

describe PlayGamePage do

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

  describe "#human_player_turn?" do

    it "returns true when it is a player's turn" do
      @game.player_one_ai = false
      @view = PlayGamePage.new(@game)
      expect(@view.human_player_turn?).to eq true
    end

    it "returns false when it is an ai's turn" do
      @view = PlayGamePage.new(@game)
      expect(@view.human_player_turn?).to eq false
    end
  end

  describe "#report_whether_AI_or_player_turn" do
    it "reports AI when it is an AI's turn" do
      @view = PlayGamePage.new(@game)
      expect(@view.report_whether_AI_or_player_turn).to eq "<h1>AI Turn</h1>"
    end

    it "reports Player Turn when it is a player's turn" do
      @game.player_one_ai = false
      @view = PlayGamePage.new(@game)
      expect(@view.report_whether_AI_or_player_turn).to eq "<h1>Player Turn</h1>"
    end

  end

  describe "#report_player_turn_and_marker" do

    it "reports marker and number for player one" do
      @view = PlayGamePage.new(@game)
      expect(@view.report_player_turn_and_marker).to eq "<h1>It is Player One's Turn. Marker: #{@game.player_one_marker}</h1>"
    end

    it "reports marker and number for player two" do
      @game.player_turn = @player_two_marker
      @view = PlayGamePage.new(@game)
      expect(@view.report_player_turn_and_marker).to eq "<h1>It is Player Two's Turn. Marker: #{@game.player_two_marker}</h1>"
    end

  end

end
