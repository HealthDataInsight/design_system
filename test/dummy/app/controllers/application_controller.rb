# This is the application controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session if Rails.env.test?

  include DesignSystem::Branded

  before_action :add_navigation
  helper_method :brand

  private

  def add_navigation
    add_navigation_item('Manage Assistants', assistants_path)

    add_navigation_item('GOV.UK', url_for(brand: 'govuk'))
    add_navigation_item('HDI', url_for(brand: 'hdi'))
    add_navigation_item('NDRS', url_for(brand: 'ndrsuk'))
    add_navigation_item('NHS', url_for(brand: 'nhsuk'))
  end

  def brand
    @brand ||= 'nhsuk'
    @brand = params[:brand] if params[:brand]
    @brand
  end
end
