# frozen_string_literal: true

# This is the pages controller
class PagesController < ApplicationController
  layout 'two_column'

  def index
    @assistants = demo_paginated_assistants
  end

  def form_handler
    redirect_to root_url
  end
end
