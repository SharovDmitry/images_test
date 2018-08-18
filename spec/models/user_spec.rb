require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is should have auth token after create' do
    user = create(:user)
    expect(user.auth_token).not_to be_empty
  end

  it 'is should have unique token' do
    user = create(:user)
    expect(User.new(auth_token: user.auth_token)).to_not be_valid
  end
end
