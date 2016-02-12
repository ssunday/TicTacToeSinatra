require 'rspec'
require 'game_utility_functions'
require 'game'

include GameUtilityFunctions

describe "Tic Tac Toe Utility Functions" do

  def win_game_player_two
<<<<<<< HEAD
<<<<<<< HEAD
    @game.game_board = serialize_board([\
=======
=======
>>>>>>> origin/master
<<<<<<< Updated upstream
    @game.game_board = serialize_board([\
=======
    @game.game_board = [\
>>>>>>> Stashed changes
<<<<<<< HEAD
>>>>>>> origin/master
=======
>>>>>>> origin/master
      @game.player_two_marker, "1", @game.player_two_marker, \
      @game.player_two_marker, @game.player_one_marker, @game.player_one_marker, \
      @game.player_two_marker, "7", "8"])
  end

  def win_game_player_one
<<<<<<< HEAD
<<<<<<< HEAD
    @game.game_board = serialize_board([\
=======
=======
>>>>>>> origin/master
<<<<<<< Updated upstream
    @game.game_board = serialize_board([\
=======
    @game.game_board = [\
>>>>>>> Stashed changes
<<<<<<< HEAD
>>>>>>> origin/master
=======
>>>>>>> origin/master
      @game.player_one_marker, "1", @game.player_two_marker, \
      @game.player_one_marker, @game.player_two_marker, @game.player_two_marker, \
      @game.player_one_marker, "7", "8"])
  end

  def tie_game
<<<<<<< HEAD
<<<<<<< HEAD
    @game.game_board =  serialize_board([\
=======
=======
>>>>>>> origin/master
<<<<<<< Updated upstream
    @game.game_board =  serialize_board([\
=======
    @game.game_board =  [\
>>>>>>> Stashed changes
<<<<<<< HEAD
>>>>>>> origin/master
=======
>>>>>>> origin/master
      @game.player_one_marker, @game.player_two_marker, @game.player_two_marker, \
      @game.player_two_marker, @game.player_one_marker, @game.player_one_marker, \
      @game.player_one_marker, @game.player_two_marker, @game.player_two_marker])
  end

  before do
    @game = Game.new
    @player_one_marker = "X"
    @player_two_marker = "O"
    set_up_game(game: @game, player_one_type: "AI", player_two_type: "Human", \
    player_one_marker: @player_one_marker, \
    player_two_marker: @player_two_marker, \
    first_player: "player_one_marker")
    @game.save
  end

  describe "#set_up_game" do

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
    it "creates a new rules class based on game data passed in" do
      game_rules = create_new_game_rules(@game)
      expect(game_rules.get_array_board).to eq ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    end
  end

  describe "#get_location_chosen" do
    it "correctly gets location based on user input" do
      @game.player_turn = @player_two_marker
      spot = "5"
      location_chosen = get_location_chosen(@game, spot)
      expect(location_chosen).to eq 5
    end

    it "correctly gets location based on AI input" do
      @game.player_turn = @player_one_marker
      spot = nil
      location_chosen = get_location_chosen(@game, spot)
      expect(location_chosen).to eq 0
    end
  end

  describe "#game_turn" do
    it "correctly plays a turn with AI going" do
      game_rules = create_new_game_rules(@game)
      game_turn(@game, game_rules, nil)
<<<<<<< HEAD
<<<<<<< HEAD
      expect(de_serialize_board(@game.game_board)).to eq ["X", "1", "2", "3", "4", "5", "6", "7", "8"]
=======
=======
>>>>>>> origin/master
<<<<<<< Updated upstream
      expect(de_serialize_board(@game.game_board)).to eq ["X", "1", "2", "3", "4", "5", "6", "7", "8"]
=======
      expect(@game.game_board).to eq ["X", "1", "2", "3", "4", "5", "6", "7", "8"]
>>>>>>> Stashed changes
<<<<<<< HEAD
>>>>>>> origin/master
=======
>>>>>>> origin/master
    end

    it "correctly plays a turn with player going" do
      @game.player_turn = @player_two_marker
      game_rules = create_new_game_rules(@game)
      game_turn(@game, game_rules, 4)
<<<<<<< HEAD
<<<<<<< HEAD
      expect(de_serialize_board(@game.game_board)).to eq ["0", "1", "2", "3", "O", "5", "6", "7", "8"]
=======
=======
>>>>>>> origin/master
<<<<<<< Updated upstream
      expect(de_serialize_board(@game.game_board)).to eq ["0", "1", "2", "3", "O", "5", "6", "7", "8"]
=======
      expect(@game.game_board).to eq ["0", "1", "2", "3", "O", "5", "6", "7", "8"]
>>>>>>> Stashed changes
<<<<<<< HEAD
>>>>>>> origin/master
=======
>>>>>>> origin/master
    end
  end

  describe "#assign_end_game_state" do

    it "assigns player one win as a player one win" do
      @game.player_turn = @player_two_marker
      win_game_player_one
      game_rules = create_new_game_rules(@game)
      assign_end_game_state(@game, game_rules)
      expect(@game.end_game_state).to eq "Player One Won"
    end

    it "assigns player two win as a player two win" do
      win_game_player_two
      game_rules = create_new_game_rules(@game)
      assign_end_game_state(@game, game_rules)
      expect(@game.end_game_state).to eq "Player Two Won"
    end

    it "assigns tied as tied" do
      tie_game
      game_rules = create_new_game_rules(@game)
      assign_end_game_state(@game, game_rules)
      expect(@game.end_game_state).to eq "Tied"
    end

  end

end
