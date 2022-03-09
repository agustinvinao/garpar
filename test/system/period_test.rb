require 'application_system_test_case'

class PeriodsTest < ApplicationSystemTestCase
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

  test 'viewing the index' do
    visit user_company_client_period_path(@user, @company, @client, @period)
    assert_selector 'div.container.print', text: "#{@company.name}2"
  end
end
