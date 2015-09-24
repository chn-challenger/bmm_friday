require 'spec_helper'
require 'launchy'
require 'byebug'
feature 'User sign up' do

  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content "Welcome, alice@example.com"
    expect(User.first.email).to eq "alice@example.com"
  end

  def sign_up(email: "alice@example.com",
              password: 'oranges!',
              password_confirmation: 'oranges!')
      visit '/users/new'
      expect(page.status_code).to eq 200
      fill_in :email, with: email
      fill_in :password, with: password
      fill_in :password_confirmation, with: password_confirmation
      click_button "Sign up"
  end

  scenario 'requires a matching password confirmation' do
    expect {sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq('/users') #current_path is a helper
                                         # provided by Capybara
    expect(page).to have_content 'Password and confirmation password do not match'
  end

  scenario 'cannot sign up when the email field is empty' do
    expect { sign_up(email: "") }.not_to change(User, :count)
    # expect(current_path).to eq('/users')
    # expect(page).to have_content "Please enter an email address"
  end
end
