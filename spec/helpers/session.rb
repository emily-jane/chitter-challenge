module SessionHelpers

 def sign_in(email:, password:)
   visit '/sessions/new'
    expect(page.status_code).to eq(200)
    fill_in :email,    with: email
    fill_in :password, with: password
    click_button 'Sign in'
 end

  def sign_up(email: 'test@test.com',
              password: 'password',
              name: 'name',
              username: 'username',
              password_confirmation: 'password')
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email,    with: email
    fill_in :password, with: password
    fill_in :name, with: name
    fill_in :username, with: username
    fill_in :password_confirmation, with: password_confirmation
    click_button 'Sign up'
  end
end