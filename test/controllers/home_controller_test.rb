require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should redirect to login' do
    get root_url
    assert_response :success
  end

  test 'should get welcome' do
    sign_in FactoryBot.create(:user)
    get root_url
    assert_response :success
  end
end
