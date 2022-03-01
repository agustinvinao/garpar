class Devise::SessionsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def setup
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = FactoryBot.create(:user)
  end

  test "redirects to user's companies list on sign_in" do
    post :create, params: { user: { 'email' => @user.email, 'password' => @user.password, 'remember_me' => 0 } }
    assert_redirected_to user_companies_path(@user)
  end

  test 'redirects to root on sign_out' do
    delete :destroy
    assert_redirected_to root_path
  end
end
