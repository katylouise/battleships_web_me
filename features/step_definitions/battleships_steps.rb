Given /^(?:|I )am on the (.+)$/ do |page_name|
  visit path_to(page_name)
end

When(/^I press "([^"]*)"$/) do |button|
  click_button button
end

Then(/^I should see "([^"]*)"$/) do |text|
  expect(page).to have_content(text)
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |textbox, entry|
  fill_in textbox, with: entry
end

And(/^I page should have "([^"]*)"$/) do |text|
  expect(page).to have_content(text)
end
