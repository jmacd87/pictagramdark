require 'rails_helper.rb'

feature 'Creating a new user' do
  background do
    visit '/signup'
  end
  scenario 'can create a new user via the index page' do
    fill_in 'User Name', with: 'sxyrailsdev'
    fill_in 'Email', with: 'sxyrailsdev@myspace.com'
    fill_in 'Password', with: 'supersecret', match: :first
    fill_in 'Confirm Password', with: 'supersecret'

    click_button 'Sign up'
    expect(page).to have_content('User was successfully created.')
  end
end