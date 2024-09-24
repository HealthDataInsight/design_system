# frozen_string_literal: true

module DesignSystem
  module Components
    # This class helps to design Tab component
    class Tab
      attr_accessor :tabs, :title

      def initialize
        @tabs = []
      end

      def add_tab_panel(name, content, id, sel: false)
        @tabs << [name, content, id, sel]
      end
    end
  end
end
