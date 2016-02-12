require 'data_mapper'
require File.expand_path '../../lib/game.rb', __FILE__

DataMapper.setup(:default, "abstract::")

describe Game do

  before do
    @player_one_marker = "X"
    @player_two_marker = "O"
    @player_turn = @player_one_marker
    @player_one_ai = false
    @player_two_ai = true
    @game_board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @active = true
  end

  it "creates a game with assignable player one marker" do
    game = Game.new
    game.player_one_marker = @player_one_marker
    expect(game.player_one_marker).to eq @player_one_marker
  end

  it "creates a game with assignable player two marker" do
    game = Game.new
    game.player_two_marker = @player_two_marker
    expect(game.player_two_marker).to eq @player_two_marker
  end

  it "creates a game with a player turn property" do
    game = Game.new
    game.player_turn = @player_turn
    expect(game.player_turn).to eq @player_turn
  end

  it "creates a game with a game board property that can hold an array" do
    game = Game.new
<<<<<<< HEAD
<<<<<<< HEAD
    game.game_board = @game_board.join(' ')
    expect(game.game_board.split(' ')).to eq @game_board
=======
=======
>>>>>>> origin/master
<<<<<<< Updated upstream
    game.game_board = @game_board.join(' ')
    expect(game.game_board.split(' ')).to eq @game_board
=======
    game.game_board = @game_board
    expect(game.game_board).to eq @game_board
>>>>>>> Stashed changes
<<<<<<< HEAD
>>>>>>> origin/master
=======
>>>>>>> origin/master
  end

  it "creates a game with a boolean for whether player one is an ai" do
    game = Game.new
    game.player_one_ai = @player_one_ai
    expect(game.player_one_ai).to eq @player_one_ai
  end

  it "creates a game with a boolean for whether player two is an ai" do
    game = Game.new
    game.player_two_ai = @player_two_ai
    expect(game.player_two_ai).to eq @player_two_ai
  end

  it "creates a game with a boolean for game state" do
    game = Game.new
    game.active = @active
    expect(game.active).to eq @active
  end

  it "creates a game with a string property for end_game_state that can be nil" do
    game = Game.new
    end_game_state = nil
    game.end_game_state = end_game_state
    expect(game.end_game_state).to eq end_game_state
  end

  it "creates a game with a string property for end_game_state that can be a string" do
    game = Game.new
    end_game_state = "Player One Won"
    game.end_game_state = end_game_state
    expect(game.end_game_state).to eq end_game_state
  end

end
