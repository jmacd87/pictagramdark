require 'rails_helper.rb'

feature 'Creating posts' do
	background do
		user= create(:user)
	end
  scenario 'can create a post' do
    visit '/'
    visit '/posts/new'
    attach_file('Image', "spec/files/images/anchorstamp.png")
    fill_in 'Caption', with: 'nom nom nom #coffeetime' 
    click_button 'Create Post'
    expect(page).to have_content('#coffeetime')
    expect(page).to have_css("img[src*='anchorstamp.png']")
  end
end