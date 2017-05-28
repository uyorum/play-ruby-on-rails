require 'rails_helper'

feature 'Session Management' do
  scenario "login with valid information and logout", js: true do
    user = create(:activated_user)

    visit root_path
    click_link 'Log in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    find_link 'Account'

    expect(current_path).to eq user_path(user)
    click_link 'Account'
    expect(page).to have_content 'Log out'

    click_link 'Users'
    expect(page).to have_selector 'h1', text: 'All users'
    expect(current_path).to eq users_path

    click_link 'Account'
    click_link 'Log out'
    find_link 'Log in'
    expect(current_path).to eq root_path
  end
end
