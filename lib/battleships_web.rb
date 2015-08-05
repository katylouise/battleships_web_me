require 'sinatra/base'
require 'battleships'

class BattleshipsWeb < Sinatra::Base

  attr_reader :playername

  enable :sessions

  set :views, Proc.new { File.join(root, "..", "views") }

  get '/' do
    erb :index
  end

  get '/newgame' do
    erb :newgame
  end

  post '/newgame' do
    session[:playername] = params[:playername]
    redirect '/newgame' if session[:playername] == ""
    redirect '/game'
  end

  get '/game' do
    $game = Game.new Player, Board
    erb :game
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
