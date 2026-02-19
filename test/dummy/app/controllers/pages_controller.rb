# frozen_string_literal: true

require 'will_paginate/array'
# This is the pages controller
class PagesController < ApplicationController
  layout 'with_sidebar'
  before_action :set_sidebar_sections

  SIDEBAR_CONTENT = [
    {
      heading: 'Design',
      items: %w[
        styles
        components
      ]
    }
  ].freeze

  def index
    # Using an array to simulate records
    assistants = [
      Assistant.new(title: '1'),
      Assistant.new(title: '2'),
      Assistant.new(title: '3')
    ]

    # Paginate the array
    @assistants = assistants.paginate(page: params[:page], per_page: 1)
    flash.now.notice = 'Alerts and notices have been added'
  end

  def form_handler
    redirect_to root_url
  end
end
