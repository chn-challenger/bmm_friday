require 'spec_helper'
require 'launchy'
feature 'User sign up' do

  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content "Welcome, alice@example.com"
    expect(User.first.email).to eq "alice@example.com"
  end

  def sign_up(email: "alice@example.com",
              password: 'oranges!',
              password_confirmation: 'oranges!')

      p password_confirmation
      visit '/users/new'
      expect(page.status_code).to eq 200
      fill_in :email, with: email
      fill_in :password, with: password
      fill_in :password_confirmation, with: password_confirmation
      click_button "Sign up"
  end

  scenario ' requires a matching passward confirmation' do
    expect {sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
  end


end
