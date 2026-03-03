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

  # TODO: review whether this is needed given we have it in the pages controller (which we are not using anymore). At least remove one of them
  def set_component_preview_data
    return unless @component == 'pagination'

    @assistants = demo_paginated_assistants
  end
end
