class ClientsController < ApplicationController
  before_action :load_company
  before_action :load_client, only: %(show)
  before_action :set_breadcrum, only: %(show)
  def index; end

  def show
    @selected_year = params[:year] || nil
    @selected_month = params[:month] || nil
  end

  private

  def load_company
    @company = Company.find(params[:company_id])
  end

  def load_client
    @client = Client.find(params[:id])
  end

  def set_breadcrum
    add_breadcrum(@company.name, user_company_path(current_user, @company), false)
    add_breadcrum(@client.name, user_company_client_path(current_user, @company, @client),
                  action_name == 'show' && params[:year].nil? && params[:month].nil?
    )
    if params[:year]
      add_breadcrum(params[:year], user_company_client_path(current_user, @company, @client, { year: params[:year] }),
                    action_name == 'show' && params[:year] && params[:month].nil?
      )
    end
    if params[:year] && params[:month]
      add_breadcrum(Date::MONTHNAMES[params[:month].to_i],
                    user_company_client_path(current_user, @company, @client, { year: params[:year], month: params[:month] }), action_name == 'show' && params[:year] && params[:month]
      )
    end
  end
end
