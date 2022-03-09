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
    company = FactoryBot.create(:company_address).addressable
    sign_in company.user
    get user_company_path(company.user, company)
    assert_response :success
    assert_equal 'show', @controller.action_name
  end

  test 'breadcrumb show action' do
    company = FactoryBot.create(:company_address).addressable
    sign_in company.user
    get user_company_path(company.user, company)
    breadcrums = @controller.instance_variable_get(:@breadcrums)
    assert_equal 2, breadcrums.size
    assert_equal %i[title path current], breadcrums.first.keys
    assert_equal 'Companies', breadcrums.first[:title]
    assert_equal user_companies_path(company.user), breadcrums.first[:path]
    assert breadcrums.last[:current]
  end
end
