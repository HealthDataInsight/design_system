class ApplicationController < ActionController::Base
  include DesignSystem::Branded

  def brand
    @brand ||= 'nhsuk'
    @brand = params[:brand] if params[:brand]
    @brand
  end
end
