require_relative 'game.rb'
require_relative 'game_utility_functions.rb'


DataMapper.setup(:default, 'postgres://xeuqunygyaxxxv:f7RVOavZHHpP_SFrunnlEN1ErQ@ec2-54-225-195-249.compute-1.amazonaws.com:5432/do4clntk7ijkk')
DataMapper.auto_upgrade!
DataMapper.finalize

module GameModelWrapper

  include GameUtilityFunctions

  def create_game(params = {})
    game = Game.new
		set_up_game(game: game, player_one_marker: params[:player_one_marker], \
		player_two_marker: params[:player_two_marker],\
		first_player: params[:first_player], player_one_type: params[:player_one_type], player_two_type: params[:player_two_type])
		game.save
    game
  end

  def do_game_turn(game, spot)
  	game_rules = create_new_game_rules(game)
  	game_turn(game, game_rules, spot)
  	game.save
  end

  def active?(game)
    game.active
  end

  def get_id_of_game(game)
    Game.id
  end

  def get_game_given_id(game_id)
    Game.get(game_id)
  end

  def get_finished_games
    Game.all(:active => false)
  end

  def get_unfinished_games
    Game.all(:active => true)
  end

end
