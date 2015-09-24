require 'spec_helper'

describe User do

  let!(:user) { create :user }
  let!(:fake_user) { create(:user, password: 'wrong') }

  it 'authenticates when given a valid email address and password' do
    authenticated_user = User.authenticate(user.email, user.password)
    expect(authenticated_user).to eq user
  end

  it 'does not authenticate when given an incorrect password' do
    authenticated_user = User.authenticate(fake_user.email, fake_user.password)
    expect(authenticate_user).to be_nil
  end

end
