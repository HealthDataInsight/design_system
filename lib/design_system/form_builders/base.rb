# require_relative 'base'

module DesignSystem
  module FormBuilders
    # The base version of the form builder
    class Base < ActionView::Helpers::FormBuilder
      delegate :content_tag, :tag, :safe_join, :link_to, :capture, to: :@template

      def self.brand
        name.demodulize.underscore
      end
    end
  end
end
