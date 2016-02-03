require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../main.rb', __FILE__

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

  describe "Settings" do

    before do
      @player_one_marker = "X"
      @player_two_marker = "O"
    end

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

    before do
      @player_one_marker = "X"
      @player_two_marker = "O"
      post '/settings', :player_one_marker => @player_one_marker, :player_two_marker => @player_two_marker, :player_one_type => "Human", :player_two_type => "Human", :first_player => "player_one_marker"
    end

    it "should be ok" do
      get '/play_game', :game_id => 3
      expect(last_response).to be_ok
    end

    it "should post with player input" do
      follow_redirect!
      post '/play_game', :game_id => 5, :spot => "0"
      expect(last_response).to be_ok
    end

    it "should post with player input and switch to next turn" do
      follow_redirect!
      post '/play_game', :game_id => 6, :spot => "0"
      get '/play_game', :game_id => 6
      expect(last_response.body).to include("Marker: #{@player_two_marker}")
    end

    it "should post with player input and show marked location" do
      follow_redirect!
      post '/play_game', :game_id => 7, :spot => "0"
      get '/play_game', :game_id => 7
      expect(last_response.body).to include(@player_one_marker)
    end

    it "should go to end game and show won when game has been won" do
      follow_redirect!
      post '/play_game', :game_id => 8, :spot => "0"
      post '/play_game', :game_id => 8, :spot => "1"
      post '/play_game', :game_id => 8, :spot => "3"
      post '/play_game', :game_id => 8, :spot => "4"
      post '/play_game', :game_id => 8, :spot => "6"
      post '/play_game', :game_id => 8, :spot => "7"
      expect(last_response.body).to include("Won")
    end

    it "should go to end game and show tied when game has been tied" do
      follow_redirect!
      post '/play_game', :game_id => 9, :spot => "0"
      post '/play_game', :game_id => 9, :spot => "1"
      post '/play_game', :game_id => 9, :spot => "2"
      post '/play_game', :game_id => 9, :spot => "3"
      post '/play_game', :game_id => 9, :spot => "4"
      post '/play_game', :game_id => 9, :spot => "6"
      post '/play_game', :game_id => 9, :spot => "5"
      post '/play_game', :game_id => 9, :spot => "8"
      post '/play_game', :game_id => 9, :spot => "7"
      expect(last_response.body).to include("Tied")
    end

  end

end
