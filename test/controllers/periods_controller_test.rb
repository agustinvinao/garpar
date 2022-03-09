require 'test_helper'

class PeriodsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user     = FactoryBot.create(:user)
    @company  = FactoryBot.create(:company_address).addressable
    @client   = client_address_with_periods(count: 1).addressable
    @company.clients << @client
    @user.companies << @company
    @company  = @user.companies.first
    @client   = @company.clients.first
    @period   = @client.periods.first
    sign_in(@user)
  end

  test 'should get show' do
    get user_company_client_period_path(@user, @company, @client, @period)
    assert_response :success
    assert_equal 'show', @controller.action_name
    assert_includes @controller.view_assigns, 'company'
    assert_includes @controller.view_assigns, 'client'
    assert_includes @controller.view_assigns, 'period'
  end

  test 'should get invoice' do
    get user_company_client_period_invoice_path(
      @user, @company, @client, @period
    )
    assert_response :success
    assert_equal 'invoice', @controller.action_name
    assert_includes @controller.view_assigns, 'company'
    assert_includes @controller.view_assigns, 'client'
    assert_includes @controller.view_assigns, 'period'
  end

  test 'should get expense' do
    get user_company_client_period_expense_path(
      @user, @company, @client, @period
    )
    assert_response :success
    assert_equal 'expense', @controller.action_name
    assert_includes @controller.view_assigns, 'company'
    assert_includes @controller.view_assigns, 'client'
    assert_includes @controller.view_assigns, 'period'
  end

  test 'breadcrums / show' do
    period = FactoryBot.build(:period, client: @client)
    period.due = @period.due.end_of_month
    period.year = period.due.year
    period.month = period.due.month
    period.save!

    get user_company_client_period_path(@user, @company, @client, period, { year: period.year, month: period.month })
    assert_equal 'show', @controller.action_name
    breadcrums = @controller.instance_variable_get(:@breadcrums)
    assert_equal 6, breadcrums.size
  end
end
