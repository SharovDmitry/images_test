module AuthHelper
  def authenticate_user
    @user = create(:user)
    allow(controller).to receive(:check_auth_token).and_return(true)
    allow(controller).to receive(:current_user).and_return(@user)
  end
end
