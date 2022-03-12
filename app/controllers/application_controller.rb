require 'breadcrumb'
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :store_user_location!, if: :storable_location?
  before_action :load_breadcrum

  private

  # Its important that the location is NOT stored if:
  # - The request method is not GET (non idempotent)
  # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an
  #    infinite redirect loop.
  # - The request is an Ajax request as this can lead to very unexpected behaviour.
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

  def after_sign_in_path_for(resource_or_scope)
    # stored_location_for(resource_or_scope)
    user_companies_path(resource_or_scope)
  end

  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end

  def load_breadcrum
    @breadcrums = []
    add_breadcrum('Home', root_path, true)
    return unless current_user

    breadcrumb_companies if %w[home companies].include?(controller_name) || params[:company_id]
    breadcrumb_clients if controller_name == 'clients' || params[:client_id]
    breadcrumb_periods if controller_name == 'periods'
  end

  def breadcrumb_companies
    add_breadcrum('Companies', user_companies_path(current_user), breadcrumb_is_current('companies', 'index'))
    company_id = param_id('company')
    return unless company_id

    company = Company.find(company_id)
    add_breadcrum(company.name, user_company_path(current_user, company), breadcrumb_is_current('companies', 'show')) if action_name == 'show'
  end

  def breadcrumb_clients
    company = Company.find(params[:company_id])
    client = Client.find(param_id('client'))

    return unless action_name == 'show' && client

    add_breadcrum(
      client.name,
      user_company_client_path(current_user, company, client),
      breadcrumb_is_current('clients', 'show')
    )

    if params[:year]
      add_breadcrum(
        params[:year],
        user_company_client_path(current_user, company, client, { year: params[:year] }),
        breadcrumb_is_current('clients', 'index')
      )
    end

    if params[:month]
      add_breadcrum(
        Date::MONTHNAMES[params[:month].to_i],
        user_company_client_path(current_user, company, client, { year: params[:year], month: params[:month] }),
        breadcrumb_is_current('clients', 'index')
      )
    end
  end

  def breadcrumb_periods
    company = Company.find(params[:company_id])
    client = Client.find(params[:client_id])
    period = Period.find(param_id('period'))
    query_params = %i[year month].reduce([]) do |query, key|
      query << [key, params[key]] if params[key]
    end.to_h

    return unless period && action_name == 'show'

    add_breadcrum(
      period.due,
      user_company_client_period_path(current_user, company, client, period, query_params),
      breadcrumb_is_current('clients', 'show')
    )
  end

  def breadcrumb_is_current(controller, action)
    controller_name == controller && action_name == action
  end

  def add_breadcrum(title, path, is_current)
    @breadcrums << {
      title: title,
      path: path,
      current: is_current || false
    }
  end

  def param_id(key)
    params[:"#{key}_id"] || params[:id]
  end
end
