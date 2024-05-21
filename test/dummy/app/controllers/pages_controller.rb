# This is the pages controller
class PagesController < ApplicationController
  def index; end

  def form_handler
    redirect_to root_url
  end
end
