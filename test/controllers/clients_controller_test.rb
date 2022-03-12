require 'test_helper'

class ClientsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user     = FactoryBot.create(:user)
    @company  = FactoryBot.create(:company_address).addressable
    @client   = FactoryBot.create(:client_address).addressable
    @company.clients << @client
    @user.companies << @company
    @company  = @user.companies.first
    @client   = @company.clients.first
    sign_in(@user)
  end

  test 'should get show' do
    get user_company_client_path(@user, @company, @client)
    assert_response :success
    assert_equal 'show', @controller.action_name
  end

  test 'breadcrums - year' do
    @client.periods << FactoryBot.create(:period)
    get user_company_client_path(@user, @company, @client, { year: @client.periods.first.year })
    assert_response :success
    assert_equal 'show', @controller.action_name
    breadcrums = @controller.instance_variable_get(:@breadcrums)
    assert_equal 5, breadcrums.size
  end

  test 'breadcrums - year / month' do
    @client.periods << FactoryBot.create(:period)
    get user_company_client_path(@user, @company, @client, { year: @client.periods.first.year, month: @client.periods.first.month })
    assert_response :success
    assert_equal 'show', @controller.action_name
    breadcrums = @controller.instance_variable_get(:@breadcrums)
    assert_equal 6, breadcrums.size
  end
end
