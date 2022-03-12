class PeriodsController < ApplicationController
  before_action :load_company
  before_action :load_client
  before_action :load_period, only: %i[show invoice expense]

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

  def set_layout
    %w[invoice expense].include?(action_name) ? 'blank' : 'application'
  end
end
