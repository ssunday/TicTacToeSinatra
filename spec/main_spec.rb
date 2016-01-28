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

    it "can post" do
      post '/settings'
      expect(last_response).to be_ok
    end

    it "does not redirect" do
      get '/settings'
      expect(last_response.redirect?).to eq false
    end

  end

  it "Settings goes to play_game" do
    post '/settings', :player_one_marker => "X", :player_two_marker => "O", :player_one_type => "AI", :player_two_type => "AI", :first_player => "player_one_marker"
    expect(last_response).to be_ok
  end

  xit "Play game redirects after end" do
    post '/settings', :player_one_marker => "X", :player_two_marker => "O", :player_one_type => "Human", :player_two_type => "Human", :first_player => "player_one_marker"
    post '/play_game' , :spot => 0
    post '/play_game' , :spot => 1
    post '/play_game' , :spot => 2
    post '/play_game' , :spot => 3
    post '/play_game' , :spot => 4
    post '/play_game' , :spot => 5
    post '/play_game' , :spot => 6
    post '/play_game' , :spot => 7
    post '/play_game' , :spot => 8
    expect(last_response).to be_ok
  end

  xit "Won game goes to won end game screen" do
    post '/settings', :player_one_marker => "X", :player_two_marker => "O", :player_one_type => "Human", :player_two_type => "Human", :first_player => "player_one_marker"
    post '/play_game' , :spot => 0
    post '/play_game' , :spot => 1
    post '/play_game' , :spot => 2
    post '/play_game' , :spot => 3
    post '/play_game' , :spot => 4
    post '/play_game' , :spot => 5
    post '/play_game' , :spot => 6
    post '/play_game' , :spot => 7
    post '/play_game' , :spot => 8
    expect(last_response.body.include?('Won')).to eq true
  end

  xit "Tied game goes to tied end game screen" do
    post '/settings', :player_one_marker => "X", :player_two_marker => "O", :player_one_type => "Human", :player_two_type => "Human", :first_player => "player_one_marker"
    post '/play_game' , :spot => 0
    post '/play_game' , :spot => 2
    post '/play_game' , :spot => 1
    post '/play_game' , :spot => 4
    post '/play_game' , :spot => 5
    post '/play_game' , :spot => 3
    post '/play_game' , :spot => 6
    post '/play_game' , :spot => 7
    post '/play_game' , :spot => 8
    expect(last_response.body.include?('Tied')).to eq true
  end

end
