class CompaniesController < ApplicationController
  before_action :load_company, only: %(show)
  before_action :set_breadcrum, only: %(show)
  def index; end

  def show; end

  private

  def load_company
    @company = Company.find(params[:id])
  end

  def set_breadcrum
    add_breadcrum(@company.name, user_company_path(current_user, @company), action_name == 'show')
  end
end
