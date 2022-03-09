require 'test_helper'

class ClientsHelperTest < ActionView::TestCase
  test '#client_period_years' do
    client = client_address_with_periods(count: 2).addressable
    result = client_period_years(client)
    period = client.periods.first

    assert_equal %i[title link], result.first.keys
    assert_equal client.periods.select(:year).distinct.size, result.size
    assert_equal user_company_client_path(
      client.company.user,
      client.company,
      client,
      { year: period.year }
    ), result.first[:link]
  end

  test '#client_periods_year_months / multiple periods' do
    client = client_address_with_periods(count: 2).addressable
    period = client.periods.first
    result = client_periods_year_months(client, period.year)

    assert_equal %i[title link], result.first.keys
    assert_equal Date::MONTHNAMES[period.month], result.first[:title]
    link = if client.periods.size == 1
             user_company_client_period_path(client.company.user, client.company, client, period, { year: period.year, month: period.month })
           else
             user_company_client_path(client.company.user, client.company, client, { year: period.year, month: period.month })
           end
    assert_equal link, result.first[:link]
  end

  test '# client_periods_year_months / signle period' do
    client = client_address_with_periods(count: 1).addressable
    period = client.periods.first
    result = client_periods_year_months(client, period.year)

    assert_equal %i[title link], result.first.keys
    assert_equal Date::MONTHNAMES[period.month], result.first[:title]
    link = if client.periods.size == 1
             user_company_client_period_path(client.company.user, client.company, client, period, { year: period.year, month: period.month })
           else
             user_company_client_path(client.company.user, client.company, client, { year: period.year, month: period.month })
           end
    assert_equal link, result.first[:link]
  end

  test '#client_periods_year_month' do
    client = client_address_with_periods(count: 2).addressable
    period = client.periods.first
    result = client_periods_year_month(client, period.year, period.month)

    assert_equal %i[title link], result.first.keys
    assert_equal user_company_client_period_path(client.company.user, client.company, client, period, { year: period.year, month: period.month }),
                 result.first[:link]
  end
end
