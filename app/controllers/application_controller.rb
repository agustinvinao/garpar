require 'breadcrumb'
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :store_user_location!, if: :storable_location?
  before_action :breadcrum

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

  def breadcrum
    @breadcrums = []
    if current_user
      add_breadcrum('Companies', user_companies_path(current_user),
                    controller_name == 'companies' && action_name == 'index'
      )
    else
      add_breadcrum('Home', root_path, false)
    end
  end

  def add_breadcrum(title, path, current)
    @breadcrums << {
      title: title,
      path: path,
      current: current
    }
  end
end
