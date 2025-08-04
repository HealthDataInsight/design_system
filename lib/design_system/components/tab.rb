# frozen_string_literal: true

module DesignSystem
  module Components
    # This class helps to design Tab component
    class Tab
      attr_accessor :tabs, :title

      def initialize(view_context = nil)
        @view_context = view_context
        @tabs = []
      end

      def add_tab_panel(name, content, id = nil, selected: false, &block)
        content ||= @view_context.capture(&block) if block_given?
        @tabs << [name, content, id, selected]
      end
    end
  end
end
