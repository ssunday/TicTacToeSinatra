require 'rspec'
require File.expand_path '../../lib/game_model_wrapper.rb', __FILE__

describe GameModelWrapper do

  before do
    @player_one_marker = "X"
    @player_two_marker = "O"
    @first_player = "player_one_marker"
    @player_one_type = "Human"
    @player_two_type = "AI"
  end

  it "can create a game and retrieve it" do
    game = create_game(player_one_marker: @player_one_marker, \
    player_two_marker: @player_two_marker, \
    first_player: "player_one_marker", player_one_type: @player_one_type, player_two_type: @player_two_type)
    expect(game).to eq get_game_given_id(game.id)
  end

  describe "#do_game_turn" do

    it "marks board" do
      game = create_game(player_one_marker: @player_one_marker, \
      player_two_marker: @player_two_marker, \
      first_player: "player_one_marker", player_one_type: @player_one_type, player_two_type: @player_two_type)
      do_game_turn(game, "0")
<<<<<<< Updated upstream
      expect(de_serialize_board(game.game_board)).to eq [@player_one_marker, "1", "2", "3", "4", "5", "6", "7", "8"]
=======
      expect(game.game_board).to eq [@player_one_marker, "1", "2", "3", "4", "5", "6", "7", "8"]
>>>>>>> Stashed changes
    end

    it "switches turn" do
      game = create_game(player_one_marker: @player_one_marker, \
      player_two_marker: @player_two_marker, \
      first_player: "player_one_marker", player_one_type: @player_one_type, player_two_type: @player_two_type)
      do_game_turn(game, "0")
      expect(game.player_turn).to eq @player_two_marker
    end

  end

  describe "#active?" do

    it "returns true when game is first made" do
      game = create_game(player_one_marker: @player_one_marker, \
      player_two_marker: @player_two_marker, \
      first_player: "player_one_marker", player_one_type: @player_one_type, player_two_type: @player_two_type)
      expect(active?(game)).to eq true
    end

    it "returns false when game is over" do
      game = create_game(player_one_marker: @player_one_marker, \
      player_two_marker: @player_two_marker, \
      first_player: "player_one_marker", player_one_type: @player_one_type, player_two_type: @player_two_type)
<<<<<<< Updated upstream
      game.game_board = serialize_board([\
=======
      game.game_board = [\
>>>>>>> Stashed changes
        @player_one_marker, @player_one_marker, @player_two_marker, \
        @player_two_marker, "4", @player_two_marker, \
        @player_two_marker, @player_two_marker, @player_two_marker]
      do_game_turn(game, "4")
      expect(active?(game)).to eq false
    end
  end
end
