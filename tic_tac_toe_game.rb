require_relative 'tic_tac_toe_rules'
require_relative 'tic_tac_toe_ai'
require_relative 'tic_tac_toe_board'
require_relative 'tic_tac_toe_console_input_output'
require_relative "tic_tac_toe_human_player.rb"

class TicTacToeGame
  attr_reader :rules

  def initialize(args = {})
    @input_output = args.fetch(:input_output, TicTacToeConsoleInputOutput.new)
    @player_one = nil
    @player_two = nil
    @rules = nil
  end

  def run_the_game
    play = true
    while play
      start_game
      play_game
      end_game
      play = @input_output.restart?
    end
    @input_output.thanks_for_playing_message
  end

  def start_game
    @input_output.start_up_message

    player_one_marker = @input_output.ask_for_player_one_marker
    player_two_marker = @input_output.ask_for_player_two_marker(player_one_marker)

    if @input_output.ai_player_one?
      @player_one = TicTacToeAi.new(ai_marker: player_one_marker, other_player_marker: player_two_marker)
    else
      @player_one = TicTacToeHumanPlayer.new
    end

    if @input_output.ai_player_two?
      @player_two = TicTacToeAi.new(ai_marker: player_two_marker, other_player_marker: player_one_marker)
    else
      @player_two = TicTacToeHumanPlayer.new
    end

    first_player = @input_output.ask_who_is_going_first(player_one_marker, player_two_marker)
    @rules = TicTacToeRules.new(TicTacToeBoard.new, first_player: first_player, player_one: player_one_marker, player_two: player_two_marker)

    @input_output.end_start_up_message
  end


  def play_game(players = {})
    @player_one = players.fetch(:player_one, @player_one)
    @player_two = players.fetch(:player_two, @player_two)
    @input_output.display_board(rules.board.board)
    until rules.game_over?
      current_board = TicTacToeBoard.new(board: Array.new(rules.board.board))
      if rules.player_turn.eql?(rules.player_one_marker)
        @input_output.report_current_turn_one
        spot = @player_one.move(current_board, rules.player_turn)
      else
        @input_output.report_current_turn_two
        spot = @player_two.move(current_board, rules.player_turn)
      end
      @input_output.report_location_marked(rules.player_turn, spot)
      rules.game_turn(spot)
      @input_output.display_board(rules.board.board)
    end
  end

  def end_game
    if rules.player_one_won?
      @input_output.game_over_player_one_won
    elsif rules.player_two_won?
      @input_output.game_over_player_two_won
    else
      @input_output.game_over_tied
    end
  end
end
