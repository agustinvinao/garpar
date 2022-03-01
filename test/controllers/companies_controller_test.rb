require 'test_helper'

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = FactoryBot.create(:user)
  end

  test 'should get index' do
    sign_in @user
    get user_companies_path(@user)
    assert_response :success
    assert_equal 'index', @controller.action_name
  end

  test 'should get show' do
    company = FactoryBot.create(:company, user: @user)
    @user.companies << company
    sign_in @user
    get user_company_path(@user, company)
    assert_response :success
    assert_equal 'show', @controller.action_name
  end
end
