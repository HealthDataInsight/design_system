# frozen_string_literal: true

# Renders design system component preview.
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

    @assistants = demo_paginated_assistants
  end
end
