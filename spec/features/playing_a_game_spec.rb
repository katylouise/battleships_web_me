require 'spec_helper'

feature 'Setting up a game' do
  scenario 'Seeing the board' do
    visit '/game'
    expect(page).to have_content('ABCDEFGHIJ')
  end
  scenario 'Placing a ship' do
    visit '/game'
    fill_in('coordinate', with: 'A2')
    select('Destroyer', :from => 'ship')
    choose('Horizontal')
    click_button('Submit')
    expect($game.own_board_view($game.player_1)).to have_content('DD')
  end
end