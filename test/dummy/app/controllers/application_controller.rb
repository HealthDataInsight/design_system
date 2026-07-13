# frozen_string_literal: true

require 'will_paginate/array'

# This is the application controller
class ApplicationController < ActionController::Base
  include DesignSystem::Branded

  before_action :add_navigation, :set_service_name, :set_footer_links, :searchbar_url
  helper_method :brand

  private

  def add_navigation
    add_navigation_item('Manage Assistants', assistants_path, icon: 'users')

    add_navigation_item('GOV.UK', url_for(brand: 'govuk'), icon: 'ellipsis-horizontal-circle')
    add_navigation_item('NHS', url_for(brand: 'nhsuk'), icon: 'ellipsis-horizontal-circle')
  end

  def brand
    session[:brand] ||= 'nhsuk'
    session[:brand] = params[:brand] if DesignSystem::Registry.registered?(params[:brand])
    session[:brand]
  end

  def set_service_name
    @service_name = 'Design system'
  end

  def set_footer_links
    add_footer_link('Github', 'https://github.com/HealthDataInsight/design_system', target: '_blank', rel: 'noopener')
    add_footer_link('Ruby Gem', 'https://rubygems.org/gems/design_system')
    add_footer_link('Health Data Insight CIC', 'https://healthdatainsight.org.uk/')
    self.copyright_notice = 'Design System © 2026 Health Data Insight CIC'
  end

  def searchbar_url
    @searchbar_url = nil # Default is nil (hidden)
  end

  def demo_paginated_assistants
    [
      Assistant.new(title: '1'),
      Assistant.new(title: '2'),
      Assistant.new(title: '3')
    ].paginate(page: params[:page], per_page: 1)
  end
end
