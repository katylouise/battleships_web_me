get "/" do
  switch_players
  "It's #{session["current_player"]}'s turn"
  p session
end

def switch_players
  @current_player = session["current_player"].freeze
  if @current_player == "Player 1"
    session["current_player"] = "Player 2"
  elsif @current_player == "Player 2"
    session["current_player"] = "Player1 "
  else
    session["current_player"] = "Player 1"
  end
end