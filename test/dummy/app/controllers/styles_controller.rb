# frozen_string_literal: true

# Renders design system style guidance (typography, layout, etc).
class StylesController < ApplicationController
  layout 'two_column'

  def index; end

  def show
    @style = params[:id]
    render "styles/#{@style}"
  rescue ActionView::MissingTemplate
    render 'styles/default'
  end
end
