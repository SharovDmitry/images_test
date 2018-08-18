require 'rails_helper'

RSpec.describe Image, type: :model do
  before do
    @user = build(:user)
    @image = 'data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=='
  end

  it 'is valid with valid attributes' do
    expect(@user.images.new(width: 50, height: 50, file: @image)).to be_valid
  end

  it 'is not valid without width' do
    expect(@user.images.new(height: 50, file: @image)).to_not be_valid
  end

  it 'is not valid without height' do
    expect(@user.images.new(width: 50, file: @image)).to_not be_valid
  end

  it 'is not valid without file' do
    expect(@user.images.new(width: 50, height: 50)).to_not be_valid
  end

  it 'is not valid with incorrect width' do
    expect(@user.images.new(width: 'abc', height: 50, file: @image)).to_not be_valid
  end

  it 'is not valid with incorrect height' do
    expect(@user.images.new(width: 50, height: 'abc', file: @image)).to_not be_valid
  end
end
