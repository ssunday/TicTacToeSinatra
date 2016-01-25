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
  end


end
