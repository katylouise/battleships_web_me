require 'spec_helper'

feature 'Starting a new game' do
  scenario 'I am asked to enter my name' do
    visit '/'
    click_link 'New Game'
    expect(page).to have_content "What's your name?"
  end

  scenario 'request for you to fill in your name' do
    visit '/'
    click_link 'New Game'
    fill_in('name', with: 'Leon')
    click_button 'Submit'
    expect(page).to have_content "Welcome to Battleships Leon!"
  end

  scenario 'should refresh the page if no input' do
    visit '/'
    click_link 'New Game'
    fill_in('name', with: '')
    click_button 'Submit'
    expect(page).to have_content "What's your name?"
  end

  scenario 'After filling in name displays start button' do
    visit '/register'
    fill_in('name', with: 'Leon')
    click_button 'Submit'
    click_button 'Start Game'
    expect(page).to have_content "Player 1: Leon"
  end
end