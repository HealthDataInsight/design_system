# frozen_string_literal: true

# Renders design system utilities (JavaScript behaviours and helpers).
class UtilitiesController < ApplicationController
  layout 'two_column'

  def index; end

  def show
    @utility = params[:utility]
    render "utilities/#{@utility}"
  rescue ActionView::MissingTemplate
    redirect_to utilities_path
  end
end
