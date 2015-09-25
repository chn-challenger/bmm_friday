require 'spec_helper'

feature 'User sign up' do

  scenario 'I can sign up as a new user' do
    user = build :user
    expect { sign_up(user) }.to change(User, :count).by(1)
    expect(page).to have_content "Welcome, alice@example.com"
    expect(User.first.email).to eq "alice@example.com"
  end

  scenario 'requires a matching password confirmation' do
    user = build(:user, password_confirmation: 'wrong')
    expect { sign_up(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users') #current_path is a helper
                                         # provided by Capybara
    expect(page).to have_content 'Password does not match the confirmation'
  end

  scenario 'cannot sign up when the email field is empty' do
    user = build(:user, email: '')
    expect { sign_up(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    # expect(page).to have_content "Please enter an email address"
  end

  scenario 'I cannot sign up with an existing email' do
    user = create(:user)
    expect { sign_up(user) }.to change(User, :count).by(0)
    expect(page).to have_content "Email is already taken"
  end
end

feature 'User sign in' do

  scenario 'with correct credentials' do
    user = create(:user)
    sign_in(user)
    expect(page).to have_content "Welcome, #{user.email}"
  end

end

feature 'User signs out' do

  scenario 'while being signed in' do
    user = create(:user)
    sign_in(user)
    click_button 'Sign out'
    expect(page).to have_content('Goodbye!')
    expect(page).not_to have_content('Welcome, alice@example.com')
  end

end
