Given(/^I am on the homepage$/) do
  visit '/'
end

When(/^I follow "([^"]*)"$/) do |link|
  click_link(link)
end

Then(/^I should see "([^"]*)"$/) do |arg1|
  expect(page).to have_content(arg1)
end

Given(/^I am on "([^"]*)"$/) do |arg1|
  visit(arg1)
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |arg1, arg2|
  fill_in(arg1, with: arg2)
end

When(/^I press "([^"]*)"$/) do |arg1|
  click_button(arg1)
end

When(/^I select "([^"]*)" from "([^"]*)"$/) do |arg1, arg2|
    select(arg1, :from => arg2)
end

When(/^I choose "([^"]*)"$/) do |arg1|
  choose(arg1)
end
