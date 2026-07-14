module DesignSystem
  # This concern manages choosing the relevant layout for our given design system
  module Branded
    extend ActiveSupport::Concern

    included do
      attr_reader :navigation_items
      attr_reader :footer_links
      attr_accessor :copyright_notice
      attr_writer :govuk_footer_crown, :govuk_footer_licence, :govuk_footer_copyright_logo

      helper DesignSystemHelper
    end

    def brand
      raise NotImplementedError, 'You need to implement #brand in your ApplicationController'
    end

    # Hide the GOV.UK footer's Crown emblem with `self.govuk_footer_crown = :hidden`.
    def govuk_footer_crown_visible?
      @govuk_footer_crown != :hidden
    end

    # Hide the GOV.UK footer's Open Government Licence with `self.govuk_footer_licence = :hidden`.
    def govuk_footer_licence_visible?
      @govuk_footer_licence != :hidden
    end

    # Hide the Royal Arms crest above the GOV.UK footer's copyright notice with
    # `self.govuk_footer_copyright_logo = :hidden`.
    def govuk_footer_copyright_logo_visible?
      @govuk_footer_copyright_logo != :hidden
    end

    def add_navigation_item(label, path, options = {})
      @navigation_items ||= []
      @navigation_items << { label:, path:, options: }
    end

    def add_footer_link(name, href, options = {})
      @footer_links ||= []
      @footer_links << { name:, href:, options: }
    end
  end
end
