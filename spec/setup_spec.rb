require 'rspec'
require 'setup'
require 'game'
include GameSetup

describe "Tic Tac Toe Game Setup Module" do
  
  describe "#set_up_game" do

    before do
      @game = Game.new
      @player_one_marker = "X"
      @player_two_marker = "O"
      @game = set_up_game(game: @game, player_one_type: "AI", player_two_type: "Human", \
      player_one_marker: @player_one_marker, \
      player_two_marker: @player_two_marker, \
      first_player: "player_one_marker"
      )
      @game.save
    end

    it "correctly assigns AI boolean values for player one" do
      expect(@game.player_one_ai).to eq true
    end

    it "correctly assigns AI boolean values for player two" do
      expect(@game.player_two_ai).to eq false
    end

    it "assigns player one marker to player one marker value" do
      expect(@game.player_one_marker).to eq @player_one_marker
    end

    it "assigns player two marker to player two marker value" do
      expect(@game.player_two_marker).to eq @player_two_marker
    end

    it "assigns first player to player one marker" do
      expect(@game.player_turn).to eq @player_one_marker
    end

  end
  describe "#create_new_game_rules" do
    before do
      @game = Game.new
      @player_one_marker = "X"
      @player_two_marker = "O"
      @game = set_up_game(game: @game, player_one_type: "AI", player_two_type: "Human", \
      player_one_marker: @player_one_marker, \
      player_two_marker: @player_two_marker, \
      first_player: "player_one_marker"
      )
      @game.save
    end

    it "creates a new rules class based on game data passed in" do
      game_rules = create_new_game_rules(@game)
      expect(game_rules.get_array_board).to eq ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    end

  end

end
