require 'rails_helper'

feature 'Relationship Management' do
  scenario "follow a user", js: true do
    user = create(:activated_user)
    another_user = create(:activated_user)

    sign_in_as(user)
    click_link 'Users'
    expect(page).to have_link(another_user.name)

    click_link another_user.name
    expect(page).to have_selector 'h1', text: another_user.name
    expect(current_path).to eq user_path(another_user)
    expect(page).to have_selector '#followers', text: '0'
    expect(page).to have_button 'Follow'

    click_button 'Follow'
    expect(page).to have_selector '#followers', text: '1'
    expect(user.following.count).to eq(1)
  end
end
