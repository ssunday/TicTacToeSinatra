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

    it "can post with default input" do
      post '/settings'
      expect(last_response).to be_ok
    end

    it "does not redirect" do
      get '/settings'
      expect(last_response.redirect?).to eq false
    end

    it "bad input returns to settings" do
      post '/settings', :player_one_marker => "X", :player_two_marker => "X", :player_one_type => "Human", :player_two_type => "Human", :first_player => "player_one_marker"
      expect(last_request.path).to eq('/settings')
    end

    it "post redirects to play_game " do
      post '/settings', :player_one_marker => "X", :player_two_marker => "O", :player_one_type => "Human", :player_two_type => "Human", :first_player => "player_one_marker"
      follow_redirect!
      expect(last_request.path).to eq('/play_game')
    end

  end

  describe "Play game" do

    it "should be ok" do
      post '/settings', :player_one_marker => "X", :player_two_marker => "O", :player_one_type => "Human", :player_two_type => "Human", :first_player => "player_one_marker"
      follow_redirect!
      expect(last_response).to be_ok
    end

    it "should post with player input" do
      post '/settings', :player_one_marker => "X", :player_two_marker => "O", :player_one_type => "Human", :player_two_type => "Human", :first_player => "player_one_marker"
      follow_redirect!
      post '/play_game', :game_id => 1, :spot => "0"
      expect(last_response).to be_ok
    end

  end

end
