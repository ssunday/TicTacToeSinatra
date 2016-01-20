class TicTacToeHumanPlayer

  def move(board, current_player)
    spot = nil
    until spot
      puts "Please choose an open spot you want to mark by typing in the number (0-8)."
      spot = gets.chomp
      if (spot =~ /\A\d+\z/ ? false : true) || spot.to_i > 8 || spot.to_i < 0
        puts "Sorry, that is not a valid location."
        spot = nil
      end
    end
    spot.to_i
  end

end
