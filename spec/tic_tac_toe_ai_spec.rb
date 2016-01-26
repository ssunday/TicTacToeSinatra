require File.expand_path '../../tictactoe/tic_tac_toe_ai.rb', __FILE__
require File.expand_path '../../tictactoe/tic_tac_toe_board.rb', __FILE__

describe TicTacToeAi do
  attr_reader :ai_player, :board, :player_turn

  before do
    @other_player_marker = "X"
    @ai_marker = "O"
    @ai_player = TicTacToeAi.new(ai_marker: @ai_marker, other_player_marker: @other_player_marker)
    @player_turn = @ai_marker
  end

  context "initial board" do
    attr_reader :init_board
    before do
      @init_board = TicTacToeBoard.new
    end

    it "#best_move is a edge spot" do
      expect(ai_player.move(init_board, @player_turn)).to eq 0
    end

  end

  context "AI has two in a row already and the third is open" do

    xit "#best_move chooses winning move" do
      win_board = TicTacToeBoard.new(board: ["O", "O", "2", "3", "4", "5", "6", "7", "8"])
      expect(ai_player.move(win_board, @player_turn)).to eq 2
    end

    xit "#best_move chooses winning move" do
      win_board = TicTacToeBoard.new(board: ["0", "1", "O", "3", "4", "O", "6", "7", "8"])
      expect(ai_player.move(win_board, @player_turn)).to eq 8
    end

  end

  context "opponent has two in a row already and the third is open" do

    it "#best_move blocks the opponent by selecting the open spot" do
      block_board = TicTacToeBoard.new(board: ["X", "X", "2", "3", "4", "5", "6", "7", "8"])
      expect(ai_player.move(block_board, @player_turn)).to eq 2
    end

    xit "#best_move blocks the opponent by selecting the open spot" do
      block_board = TicTacToeBoard.new(board: ["0", "1", "2", "3", "4", "5", "X", "X", "8"])
      expect(ai_player.move(block_board, @player_turn)).to eq 8
    end

  end

  context "AI is given the choice of blocking the opponent from winning or winning itself" do

    xit "#best_move prioritizes winning" do
      win_block_board = TicTacToeBoard.new(board: ["X", "X", "2", "O", "O", "5", "X", "O", "X"])
      expect(ai_player.move(win_block_board, @player_turn)).to eq 5
    end

    xit "#best_move prioritizes winning" do
      win_block_board = TicTacToeBoard.new(board: ["0", "1", "2", "X", "X", "5", "O", "O", "8"])
      expect(ai_player.move(win_block_board, @player_turn)).to eq 8
    end

  end

end
