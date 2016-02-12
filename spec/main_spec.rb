require 'rack/test'
require 'rspec'
require File.expand_path '../../main.rb', __FILE__
require File.expand_path '../../lib/game.rb', __FILE__

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure { |c| c.include RSpecMixin }

configure do
  DataMapper.setup(:default, 'postgres://xeuqunygyaxxxv:f7RVOavZHHpP_SFrunnlEN1ErQ@ec2-54-225-195-249.compute-1.amazonaws.com:5432/do4clntk7ijkk')
  DataMapper.auto_migrate!
  DataMapper.finalize
end

describe "Tic Tac Toe Web App" do

  describe "should allow access to" do
    it "the home page" do
      get '/'
      expect(last_response).to be_ok
    end

    it "the settings page" do
      get '/settings'
      expect(last_response).to be_ok
    end

    it "the previous games page" do
      get '/previous_games'
      expect(last_response).to be_ok
    end

  end

  before do
    @player_one_marker = "X"
    @player_two_marker = "O"
  end

  describe "Settings" do

    it "can post with default input" do
      post '/settings'
      expect(last_response).to be_ok
    end

    it "does not redirect" do
      get '/settings'
      expect(last_response.redirect?).to eq false
    end

    it "bad input returns to settings" do
      post '/settings', :player_one_marker => @player_one_marker, :player_two_marker => @player_one_marker, \
                        :player_one_type => "Human", :player_two_type => "Human", :first_player => "player_one_marker"
      expect(last_request.path).to eq('/settings')
    end

    it "post redirects to play_game " do
      post '/settings', :player_one_marker => @player_one_marker, :player_two_marker => @player_two_marker, :player_one_type => "Human", :player_two_type => "Human", :first_player => "player_one_marker"
      follow_redirect!
      expect(last_request.path).to eq('/play_game')
    end

  end

  describe "Play game" do

    def set_up_new_game(game)
      game.player_one_marker = @player_one_marker
      game.player_two_marker = @player_two_marker
      game.player_one_ai = false
      game.player_two_ai = false
      game.player_turn = @player_one_marker
      game.game_board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"].join(' ')
      game.active = true
    end

    it "should be ok" do
      game = Game.new
      set_up_new_game(game)
  		game.save
      get '/play_game', :game_id => game.id
      expect(last_response).to be_ok
    end

    it "should post with player input" do
      game = Game.new
  		set_up_new_game(game)
  		game.save
      post '/play_game', :game_id => game.id, :spot => "0"
      expect(last_response).to be_ok
    end

    it "should post with player input and switch to next turn" do
      game = Game.new
      set_up_new_game(game)
  		game.save
      post '/play_game', :game_id => game.id, :spot => "0"
      game_turn(game, create_new_game_rules(game), "0")
      game.save
      get '/play_game', :game_id => game.id
      expect(last_response.body).to include("Marker: #{@player_two_marker}")
    end

    it "should post with player input and show marked location" do
      game = Game.new
  		set_up_new_game(game)
  		game.save
      post '/play_game', :game_id => game.id, :spot => "0"
      game_turn(game, create_new_game_rules(game), "0")
      game.save
      get '/play_game', :game_id => game.id
      expect(last_response.body).to include("Marker: #{@player_two_marker}")
      expect(last_response.body).to include(@player_one_marker)
    end

    it "should go to end game and show won when game has been won" do
      game = Game.new
      set_up_new_game(game)
  		game.save
      game.game_board = [\
          "X", "X", "O", \
          "O", "X", "X", \
          "X", "7", "O"].join(' ')
  		game.save
      post '/play_game', :game_id => game.id, :spot => "7"
      expect(last_response.body).to include("Won")
    end

    it "should go to end game and show tied when game has been tied" do
      game = Game.new
      set_up_new_game(game)
      game.game_board = [\
          "X", "X", "O", \
          "O", "O", "X", \
          "X", "7", "O"].join(' ')
  		game.save
      post '/play_game', :game_id => game.id, :spot => "7"
      expect(last_response.body).to include("Tied")
    end
  end

  describe "Previous Games" do

    it "can see previous games" do
      get '/previous_games'
      expect(last_response.body).to include("#{@player_one_marker}")
    end

  end

end
