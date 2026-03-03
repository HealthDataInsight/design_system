# frozen_string_literal: true

module DesignSystem
  module Generic
    module Builders
      # Generic list builder.
      class List < Base
        # type: :bullet, :number
        def render_list(type: :default, **options)
          raise ArgumentError, 'block required' unless block_given?

          @list = ::DesignSystem::Components::List.new
          yield @list

          tag_name = type.to_sym == :number ? :ol : :ul

          classes = ["#{brand}-list"]
          classes << "#{brand}-list--bullet" if type == :bullet
          classes << "#{brand}-list--number" if type == :number

          options = css_class_options_merge(options, classes)

          content_tag(tag_name, **options) do
            render_items
          end
        end

        private

        def render_items
          @list.items.each_with_object(ActiveSupport::SafeBuffer.new) do |item, buffer|
            content = item.is_a?(Proc) ? capture(&item) : item
            next if content.blank?

            buffer.concat(content_tag(:li, content))
          end
        end
      end
    end
  end
end
