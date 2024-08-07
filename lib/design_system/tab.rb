module DesignSystem
  # This class helps to design Tab component
  class Tab
    attr_accessor :tabs, :title

    def initialize
      @tabs = []
    end

    def add_tab_panel(name, id, sel: false)
      @tabs << [name, id, sel]
    end
  end
end
