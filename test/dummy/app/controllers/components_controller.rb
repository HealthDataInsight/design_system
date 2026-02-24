# frozen_string_literal: true

require 'will_paginate/array'

# Renders design system component preview.
# Sidebar is built from SIDEBAR_CONTENT; show action loads the component template and sets preview data.
class ComponentsController < ApplicationController
  layout 'two_column'
  before_action :set_sidebar_sections

  SIDEBAR_CONTENT = [
    {
      heading: 'Form elements',
      items: %w[
        buttons character-count checkboxes date-input error-message error-summary
        fieldset file-upload hint-text password-input radios select text-input textarea
      ]
    },
    {
      heading: 'Content presentation',
      items: %w[
        care-cards details do-dont-lists expander images inset-text notification-banners
        panel review-date summary-list table tabs tag task-list warning-callout
      ]
    },
    {
      heading: 'Navigation',
      items: %w[
        action-link back-link breadcrumbs card contents-list footer header pagination skip-link
      ]
    }
  ].freeze

  def index; end

  def show # :reek:InstanceVariableAssumption
    @component = params[:id]
    set_component_preview_data
    render "components/#{@component}"
  rescue ActionView::MissingTemplate
    render 'components/default'
  end

  private

  def set_sidebar_sections
    build_sidebar_from_sections(SIDEBAR_CONTENT)
  end

  def set_component_preview_data
    return unless @component == 'pagination'

    @assistants = [
      Assistant.new(title: '1'),
      Assistant.new(title: '2'),
      Assistant.new(title: '3')
    ].paginate(page: params[:page], per_page: 1)
  end

  def sidebar_item_path(id)
    component_path(id)
  end
end
