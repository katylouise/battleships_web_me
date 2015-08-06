require 'spec_helper.rb'

feature 'Registering two players' do
  scenario 'I want to register two players' do
    visit '/'
    click_link 'New Game'
    fill_in('name', with: 'Rebecca')
    click_button 'Submit'
    expect(page).to have_content('Welcome to Battleships Rebecca!')

    old_session = Capybara.session_name
    Capybara.session_name = :second_session

    visit '/'
    click_link 'New Game'
    fill_in('name', with: 'Zaid')
    click_button 'Submit'
    expect(page).to have_content('Welcome to Battleships Zaid!')
    Capybara.session_name = old_session
  end
end