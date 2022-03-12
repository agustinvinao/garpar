class CompaniesController < ApplicationController
  before_action :load_company, only: %(show)

  def index; end

  def show; end

  private

  def load_company
    @company = Company.find(params[:id])
  end
end
