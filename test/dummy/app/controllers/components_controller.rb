# frozen_string_literal: true

require 'will_paginate/array'

# Renders design system component preview.
# Sidebar is built from SIDEBAR_CONTENT; show action loads the component template and sets preview data.
class ComponentsController < ApplicationController
  layout 'two_column'

  def index; end

  def show # :reek:InstanceVariableAssumption
    @component = params[:id]
    set_component_preview_data
    render "components/#{@component}"
  rescue ActionView::MissingTemplate
    render 'components/default'
  end

  private

  def set_component_preview_data
    return unless @component == 'pagination'

    @assistants = [
      Assistant.new(title: '1'),
      Assistant.new(title: '2'),
      Assistant.new(title: '3')
    ].paginate(page: params[:page], per_page: 1)
  end
end
