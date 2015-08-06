require 'spec_helper'

feature 'Setting up a game' do
  before(:each) do
    $game = Game.new(Player, Board)
  end

  scenario 'Seeing the board' do
    visit '/game'
    expect(page).to have_content('ABCDEFGHIJ')
  end

  scenario 'Placing a ship' do
    visit '/game'
    fill_in('coordinate', with: 'A1')
    select('Destroyer', :from => 'ship')
    choose('Horizontal')
    click_button('Submit')
    expect($game.own_board_view($game.player_1)).to have_content('DD')
  end

   scenario 'Firing at your opponent' do
    visit '/gameplay'
    fill_in('coordinate', with: 'A4')
    click_button('Fire!')
    expect(page).to have_content('miss')
  end

  scenario 'Computer player fires at Player 1' do
    visit '/gameplay'
    fill_in('coordinate', with: 'A3')
    click_button('Fire!')
    expect(page).to have_content('Player 2: ')
  end

  scenario 'Firing at your opponent' do
    visit '/gameplay'
    fill_in('coordinate', with: 'A1')
    click_button('Fire!')
    expect(page).to have_content('miss')
  end

end