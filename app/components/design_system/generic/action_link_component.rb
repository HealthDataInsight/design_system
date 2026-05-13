module DesignSystem
  module Generic
    # Action links are calls-to-action signposting the start of a digital
    # service. Implementation differs noticeably between brands so this is
    # mostly a contract — both brand subclasses override `call`.
    class ActionLinkComponent < DesignSystem::BaseComponent
      def initialize(name = nil, options = nil, html_options = nil)
        super()
        @name = name
        @options = options || {}
        @html_options = html_options || {}
      end

      attr_reader :name, :options, :html_options
    end
  end
end
