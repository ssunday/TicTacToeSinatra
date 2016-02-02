require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../main.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure { |c| c.include RSpecMixin }

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

    it "posts to play_game with input" do
      post '/settings', :player_one_marker => "X", :player_two_marker => "O", :player_one_type => "AI", :player_two_type => "AI", :first_player => "player_one_marker"
      expect(last_response).to be_ok
    end
  end

end
