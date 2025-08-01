# This is the application controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session if Rails.env.test?

  include DesignSystem::Branded

  before_action :add_navigation, :set_service_name
  helper_method :brand

  private

  def add_navigation
    add_navigation_item('Manage Assistants', assistants_path, icon: 'users')

    add_navigation_item('GOV.UK', url_for(brand: 'govuk'), icon: 'ellipsis-horizontal-circle')
    add_navigation_item('NHS', url_for(brand: 'nhsuk'), icon: 'ellipsis-horizontal-circle')
  end

  def brand
    session[:brand] ||= 'nhsuk'
    session[:brand] = params[:brand] if params[:brand]
    session[:brand]
  end

  def set_service_name
    @service_name = 'Design system'
  end
end
