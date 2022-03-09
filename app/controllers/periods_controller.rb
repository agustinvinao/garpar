class PeriodsController < ApplicationController
  before_action :load_company
  before_action :load_client
  before_action :load_period, only: %i[show invoice expense]
  before_action :set_breadcrum, only: %(show)
  layout :set_layout

  def show; end

  def invoice; end

  def expense; end

  private

  def load_company
    @company = Company.find(params[:company_id])
  end

  def load_client
    @client = Client.find(params[:client_id])
  end

  def load_period
    @period = Period.find(params[:id] || params[:period_id])
  end

  def set_breadcrum
    add_breadcrum(@company.name, user_company_path(current_user, @company), false)
    add_breadcrum(@client.name, user_company_client_path(current_user, @company, @client), false)
    add_breadcrum(params[:year], user_company_client_path(current_user, @company, @client, { year: params[:year] }), false)
    if @client.periods.where(year: params[:year], month: params[:month]).count(:id) > 1
      add_breadcrum(Date::MONTHNAMES[params[:month].to_i],
                    user_company_client_path(current_user, @company, @client, { year: params[:year], month: params[:month] }), false
      )
    end
    add_breadcrum(@period.due,
                  user_company_client_period_path(current_user, @company, @client, @period, { year: params[:year], month: params[:month] }), true
    )
  end

  def set_layout
    %w[invoice expense].include?(action_name) ? 'blank' : 'application'
  end
end
