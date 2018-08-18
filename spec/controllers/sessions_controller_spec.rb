require 'rails_helper'

describe SessionsController, type: :controller do
  it 'should create user and return auth token with success response' do
    expect { post :create }.to change { User.count }.by(1)
    expect(response).to have_http_status(:success)
    parsed_response = JSON.parse(response.body)['data']
    created_user = User.last
    expect(parsed_response['type']).to eq('users')
    expect(parsed_response['id']).to eq(created_user.id.to_s)
    expect(parsed_response['attributes']['auth-token']).to eq(created_user.auth_token)
  end
end
