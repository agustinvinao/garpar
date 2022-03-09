module ClientsHelper
  def client_period_years(client)
    client.periods.select(:year).distinct.map do |period|
      {
        title: period.year,
        link: user_company_client_path(
          client.company.user, client.company, client, { year: period.year }
        )
      }
    end
  end

  def client_periods_year_months(client, year)
    client.periods.where(year: year).select(:id, :month, :year).group_by(&:month).values.map do |periods|
      period = periods.first
      link = user_company_client_path(client.company.user, client.company, client, { year: period.year, month: period.month })
      if periods.size == 1
        link = user_company_client_period_path(
          client.company.user, client.company, client, period, { year: period.year, month: period.month }
        )
      end
      {
        title: Date::MONTHNAMES[period.month],
        link: link
      }
    end
  end

  def client_periods_year_month(client, year, month)
    client.periods.where(year: year, month: month).map do |period|
      {
        title: period.due,
        link: user_company_client_period_path(
          client.company.user, client.company, client, period, { year: period.year, month: period.month }
        )
      }
    end
  end
end
