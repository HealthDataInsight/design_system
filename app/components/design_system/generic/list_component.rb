module DesignSystem
  module Generic
    # Plain, bullet, or numbered list rendered by ds_list.
    class ListComponent < DesignSystem::BaseComponent
      def initialize(list:, type: :default, **options)
        super()
        @list = list
        @type = type.to_sym
        @options = options
      end

      attr_reader :list, :type, :options

      def tag_name
        type == :number ? :ol : :ul
      end

      def list_options
        classes = ["#{brand}-list"]
        classes << "#{brand}-list--bullet" if type == :bullet
        classes << "#{brand}-list--number" if type == :number
        css_class_options_merge(options, classes)
      end
    end
  end
end
