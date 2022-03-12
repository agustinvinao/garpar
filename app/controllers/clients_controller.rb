class ClientsController < ApplicationController
  before_action :load_company
  before_action :load_client, only: %(show)

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
end
