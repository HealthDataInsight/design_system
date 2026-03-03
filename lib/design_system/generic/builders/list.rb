# frozen_string_literal: true

module DesignSystem
  module Generic
    module Builders
      # Generic list builder.
      class List < Base
        # type: :bullet, :number
        def render_list(type: :default, **options)
          raise ArgumentError, 'block required' unless block_given?

          @list = ::DesignSystem::Components::List.new(@context)
          yield @list

          tag_name = type.to_sym == :number ? :ol : :ul

          classes = ["#{brand}-list"]
          classes << "#{brand}-list--bullet" if type == :bullet
          classes << "#{brand}-list--number" if type == :number

          options = css_class_options_merge(options, classes)

          content_tag(tag_name, **options) do
            @list.items.each_with_object(ActiveSupport::SafeBuffer.new) do |item, buffer|
              buffer.concat(content_tag(:li, item))
            end
          end
        end
      end
    end
  end
end
