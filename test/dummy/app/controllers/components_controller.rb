# frozen_string_literal: true

require 'will_paginate/array'

# Renders design system component preview.
# Sidebar is built from SIDEBAR_CONTENT; show action loads the component template and sets preview data.
class ComponentsController < ApplicationController
  layout 'two_column'
  before_action :set_component, :set_component_preview_data, only: :show

  def index; end

  def show
    render "components/#{@component}"
  rescue ActionView::MissingTemplate
    render 'components/default'
  end

  private

  def set_component
    @component = params[:id]
  end

  def set_component_preview_data
    return unless @component == 'pagination'

    @assistants = [
      Assistant.new(title: '1'),
      Assistant.new(title: '2'),
      Assistant.new(title: '3')
    ].paginate(page: params[:page], per_page: 1)
  end
end
