require File.expand_path '../../tictactoe/tic_tac_toe_rules.rb', __FILE__
require File.expand_path '../../tictactoe/tic_tac_toe_board.rb', __FILE__


describe TicTacToeRules do

  attr_reader :player_one_marker, :player_two_marker, :rules
  before do
    @player_one_marker = "X"
    @player_two_marker = "O"
    @first_player = @player_one_marker
    initial_board = TicTacToeBoard.new
    @rules = TicTacToeRules.new(initial_board, first_player: @first_player, player_one: @player_one_marker, player_two: @player_two_marker)
  end

  it "#switch_turn succesfully switches player turn" do
    rules.switch_turn
    expect(rules.player_turn).to eq player_two_marker
  end

  describe "#game_turn" do

    before do
      rules.game_turn(0)
    end

    it "makes selected location invalid to mark" do
      expect(rules.location_valid_to_mark?(0)).to eq false
    end

    it "changes player turn" do
      expect(rules.player_turn).to eq player_two_marker
    end

  end


  context "game over" do

    context "if player one won" do
      attr_reader :rules_win_one
      before do
        board_win = TicTacToeBoard.new(board: [\
          player_one_marker, "1", player_two_marker, \
          player_one_marker, player_one_marker, player_one_marker, \
          player_one_marker, "7", "8"])
          @rules_win_one = TicTacToeRules.new(board_win, first_player: @first_player, player_one: @player_one_marker, player_two: @player_two_marker)
          @rules_win_one.switch_turn
      end


      it "#player_one_won? is true" do
        expect(rules_win_one.player_one_won?).to eq true
      end

      it "#player_two_won? is false" do
        expect(rules_win_one.player_two_won?).to eq false
      end

    end

    context "if player two won" do
      attr_reader :rules_win_two
      before do
        board_win = TicTacToeBoard.new(board: [\
          player_two_marker, "1", player_two_marker, \
          player_two_marker, player_one_marker, player_one_marker, \
          player_two_marker, "7", "8"])
          @rules_win_two = TicTacToeRules.new(board_win, first_player: @first_player, player_one: @player_one_marker, player_two: @player_two_marker)
      end

      it "#player_two_won? is true" do
        expect(rules_win_two.player_two_won?).to eq true
      end

      it "#player_one_won? is false" do
        expect(rules_win_two.player_one_won?).to eq false
      end

    end

    context "if game is tied" do
      attr_reader :rules_tie

      before do
        board_tie = TicTacToeBoard.new(board: [\
          player_one_marker, player_two_marker, player_two_marker, \
          player_two_marker, player_one_marker, player_one_marker, \
          player_one_marker, player_two_marker, player_two_marker])
        @rules_tie = TicTacToeRules.new(board_tie, first_player: @first_player, player_one: @player_one_marker, player_two: @player_two_marker)
      end

      it "#tied? is true" do
        expect(rules_tie.tied?).to eq true
      end

      it "#player_one_won? is false" do
        expect(rules_tie.player_one_won?).to eq false
      end

      it "#player_two_won? is false" do
        expect(rules_tie.player_two_won?).to eq false
      end

    end

  end

end
