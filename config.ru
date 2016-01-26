require './main'
set :database, ENV['DATABASE_URL'] || 'postgres://localhost/app-dev'
run Sinatra::Application
