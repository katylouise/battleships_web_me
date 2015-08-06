require 'spec_helper.rb'

feature 'A player wins the game' do
  let(:game) { double(:game) }
  scenario 'Go to win page' do
    visit '/gameplay'
    helper_sink_ships
    fill_in('coordinate', with: 'J8')
    click_button('Fire!')
    expect(page).to have_content('Winner!')
  end
end


def helper_sink_ships
  $game.player_1.shoot(:A2)
  $game.player_1.shoot(:A6)
  $game.player_1.shoot(:B6)
  $game.player_1.shoot(:C6)
  $game.player_1.shoot(:F3)
  $game.player_1.shoot(:F4)
  $game.player_1.shoot(:F5)
  $game.player_1.shoot(:F6)
  $game.player_1.shoot(:J2)
  $game.player_1.shoot(:J3)
  $game.player_1.shoot(:J4)
  $game.player_1.shoot(:J5)
  $game.player_1.shoot(:J6)
  $game.player_1.shoot(:J7)
end
