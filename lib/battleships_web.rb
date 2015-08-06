require 'sinatra/base'
require 'battleships'


class BattleshipsWeb < Sinatra::Base

  enable :sessions

  $game = Game.new(Player, Board)

  get '/' do
    erb :index
  end

  get '/register' do
    erb :form
  end

  post '/name' do
    session[:name] = params[:name]
    redirect '/register' if session[:name] == ""
    redirect '/welcome'
  end

  get '/welcome' do
    erb :welcome
  end

  get '/game' do
    place_computer_ships
    erb :game
  end

  post '/game' do
    @parameters = params
    $game.player_1.place_ship(Ship.send(@parameters[:ship].to_sym), @parameters[:coordinate].to_sym, @parameters[:direction].to_sym)

    redirect '/gameplay' if $game.player_1.board.ships.count > 1
    erb :game
  end

  get '/gameplay' do
    erb :gameplay
  end

  post '/gameplay' do
    @coordinate = params[:coordinate]
    @result = $game.player_1.shoot(@coordinate.to_sym)
    erb :gameplay
  end

  def place_computer_ships
    $game.player_2.place_ship(Ship.send(:submarine), :A2)
    $game.player_2.place_ship(Ship.send(:destroyer), :J2, :vertically)
    $game.player_2.place_ship(Ship.send(:cruiser), :A6)
    $game.player_2.place_ship(Ship.send(:battleship), :F3, :vertically)
    $game.player_2.place_ship(Ship.send(:aircraft_carrier), :J4, :vertically)
  end

  set :views, Proc.new { File.join(root, "..", "views") }
  # start the server if ruby file executed directly
  run! if app_file == $0

end
