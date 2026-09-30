module DesignSystem
  # This concern manages choosing the relevant layout for our given design system
  module Branded
    extend ActiveSupport::Concern

    included do
      attr_reader :navigation_items
      attr_reader :footer_links
      attr_accessor :copyright_notice
      attr_writer :govuk_footer_elements

      helper DesignSystemHelper
      helper_method :ds_root_path
    end

    def brand
      raise NotImplementedError, 'You need to implement #brand in your ApplicationController'
    end

    # Hide the GOV.UK footer's Crown emblem, Open Government Licence and copyright logo if it is not yet a verified GOV.UK product
    def govuk_footer_elements?
      @govuk_footer_elements != :hidden
    end

    def add_navigation_item(label, path, options = {})
      @navigation_items ||= []
      @navigation_items << { label:, path:, options: }
    end

    def add_footer_link(name, href, options = {})
      @footer_links ||= []
      @footer_links << { name:, href:, options: }
    end

    private

    # The path the header logo/homepage link points to. Defaults to the host
    # app's root_path; host apps can override this (e.g. if they name their
    # home route something other than :root).
    def ds_root_path
      main_app.root_path
    end
  end
end
