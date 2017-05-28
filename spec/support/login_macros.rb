module LoginMacros
  def log_in_as(user)
    session[:user_id] = user.id
  end

  def is_logged_in?
    !session[:user_id].nil?
  end

  def sign_in_as(user)
    visit root_path
    click_link 'Log in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    find_link 'Account'
  end
end
