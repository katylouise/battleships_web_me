require 'sinatra/base'
require 'battleships'


class BattleshipsWeb < Sinatra::Base

  # def self.player_1
  #   @@player_1
  # end

  # def self.player_2
  #   @@player_2
  # end

  enable :sessions

  $game = Game.new(Player, Board)

  get '/' do
    erb :index
  end

  get '/register' do
    erb :form
  end

  post '/register' do
    session[:name] = params[:name]
    session[:version] = params[:version]
    @player = session[:name]
    $players << @player
    redirect '/register' if session[:name] == ""
    if session[:version] == 'one_player'
      session[:player] = $game.player_1

      redirect '/game'
    else
      redirect '/welcome'
    end
  end

  $players = []

  get '/welcome' do
    if $players.count == 1
      session[:player] = $game.player_1
      p $game
      p "------"
      p session
      p "------"
    else
      $player_2 = session[:name]
      session[:player] = $game.player_2
      p $game
      p "-------"
      p session
    end
    redirect '/game' if $players.count == 2
    erb :welcome
  end


  get '/game' do
    erb :game
  end

  post '/game' do
    @parameters = params
    session[:player].place_ship(Ship.send(@parameters[:ship].to_sym), @parameters[:coordinate].to_sym, @parameters[:direction].to_sym)

    if session[:player].board.ships.count > 1 && session[:version] == 'one_player'
      redirect '/gameplay_one_player'
    elsif session[:player].board.ships.count > 1 && session[:version] == 'two_player'
      redirect '/gameplay_two_player'
    end
    erb :game
  end

  get '/gameplay_one_player' do
    @computer = "Computer"
    place_computer_ships
    erb :gameplay
  end

  post '/gameplay_one_player' do
    @coordinate = params[:coordinate]
    @player_1_result = $game.player_1.shoot(@coordinate.to_sym)
    @player_2_result = $game.player_2.shoot(generate_computer_coordinates)
    redirect '/winner' if $game.has_winner?
    erb :gameplay
  end

  get '/gameplay_two_player' do
    p session[:player].board.ships
    p "____________"
    p session[:player].opponent.board.ships
    erb :gameplay
  end

  post '/gameplay_two_player' do
    @coordinate = params[:coordinate]
    @player_1_result = $game.player_1.shoot(@coordinate.to_sym)
    @player_2_result = $game.player_2.shoot(@coordinate.to_sym)
    redirect '/winner' if $game.has_winner?
    erb :gameplay
  end

  get '/winner' do
    erb :winner
  end

  def place_computer_ships
    $game.player_2.place_ship(Ship.send(:submarine), :A2)
    $game.player_2.place_ship(Ship.send(:destroyer), :J2, :vertically)
    $game.player_2.place_ship(Ship.send(:cruiser), :A6)
    $game.player_2.place_ship(Ship.send(:battleship), :F3, :vertically)
    $game.player_2.place_ship(Ship.send(:aircraft_carrier), :J4, :vertically)
  end


  $coordinate_array = []


  def generate_computer_coordinates
    coordinate = [*('A'..'J')].shuffle[1,1].join + [*('1'..'10')].shuffle[1,1].join
    coordinate_skipper(coordinate)
    coordinate.to_sym
  end

  def coordinate_skipper(coordinate)
    if $coordinate_array.include?(coordinate)
      generate_computer_coordinates
    else
      $coordinate_array << coordinate
    end
  end

  set :views, Proc.new { File.join(root, "..", "views") }
  # start the server if ruby file executed directly
  run! if app_file == $0

end
