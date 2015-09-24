require 'spec_helper'
require './app/helpers/sign_up'

feature 'User sign up' do

  scenario 'I can sign up as a new user' do
    user = create :user
    expect { sign_up(user) }.to change(User, :count).by(1)
    expect(page).to have_content "Welcome, alice@example.com"
    expect(User.first.email).to eq "alice@example.com"
  end

  def sign_up(user)
      visit '/users/new'
      expect(page.status_code).to eq 200
      fill_in :email, with: user.email
      fill_in :password, with: user.password
      fill_in :password_confirmation, with: user.password_confirmation
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

  xscenario 'I cannot sign up with an existing email' do
    sign_up_as(user)
    expect { sign_up_as(user) }.to change(User, :count).by(0)
    expect(page).to have_content "Email is already taken"
  end
end
