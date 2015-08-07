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

  post '/register' do

    session[:name] = params[:name]
    session[:version] = params[:version]
    @player = session[:name]
    $players << @player

    redirect '/register' if session[:name] == ""

    if session[:version] == 'one_player'
      session[:player] = :player_1
      redirect '/game'
    else
      redirect '/welcome'
    end
  end

  $players = []

  get '/welcome' do
    if $players.count == 1
      session[:player] = :player_1
      p "Player:"
      p $game.send(session[:player])
      p "----------"
      p "Opponent:"
      p $game.send(session[:player]).opponent
      p "----------"
    else
      $player_2 = session[:name]
      session[:player] = :player_2
    end
    redirect '/game' if $players.count == 2
    erb :welcome
  end

  #Possibly use session ids?
  def change_players!
    current_player = session[:current_player]
    return session[:current_player] = :player_1 unless current_player
    if current_player == :player_1
      session[:current_player] = :player_2
    else
      current_player = :player_1
    end
  end

  get '/game' do
    erb :game
  end

  post '/game' do
    p session
    @parameters = params
    begin
      $game.send(session[:player]).place_ship(Ship.send(@parameters[:ship].to_sym), @parameters[:coordinate].to_sym, @parameters[:direction].to_sym)
    rescue RuntimeError
      @coordinate_error = true
    end
    p "----------"
    p "Player's ships:"
    p $game.send(session[:player])
    p $game.send(session[:player]).board.ships
    p "------------"
    p "Opponent's ships:"
    p $game.send(session[:player]).opponent
    p $game.send(session[:player]).opponent.board.ships
    p "-----------"
    if $game.player_1.board.ships.count > 1 && session[:version] == 'one_player'
      redirect '/gameplay_one_player'
    elsif $game.send(session[:player]).board.ships.count > 1 && session[:version] == 'two_player'
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
    begin
      @player_1_result = $game.player_1.shoot(@coordinate.to_sym)
      @player_2_result = $game.player_2.shoot(generate_computer_coordinates)
    rescue RuntimeError
      @coordinate_error = true
    end

    redirect '/winner' if $game.has_winner?
    erb :gameplay
  end

  get '/gameplay_two_player' do

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
