class PagesController < ApplicationController
  before_action :add_navigation

  def index; end

  def add_navigation
    add_navigation_item('GOV.UK', url_for(brand: 'govuk'))
    add_navigation_item('HDI', url_for(brand: 'hdi'))
    add_navigation_item('NDRS', url_for(brand: 'ndrsuk'))
    add_navigation_item('NHS', url_for(brand: 'nhsuk'))
  end
end
