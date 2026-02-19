# frozen_string_literal: true

# Controller concern: build sidebar content in before_action (like navigation_items).
# Layout renders controller.sidebar_sections via shared/_sidebar_navigation.html.erb
#
# Usage: define SIDEBAR_CONTENT constant, implement sidebar_item_path(id), then:
#   set_sidebar_sections => build_sidebar_from_sections(SIDEBAR_CONTENT)
module SidebarSections
  extend ActiveSupport::Concern

  included do
    attr_reader :sidebar_sections
  end

  def add_sidebar_section(heading, items)
    @sidebar_sections ||= []
    @sidebar_sections << { heading: heading, items: items }
  end

  # Builds sidebar from sections array of { heading:, items: [id, ...] }.
  # Calls sidebar_item_label(id) and sidebar_item_path(id) for each id.
  def build_sidebar_from_sections(sections)
    sections.each do |section|
      items = section[:items].map { |id| [sidebar_item_label(id), sidebar_item_path(id)] }
      add_sidebar_section(section[:heading], items)
    end
  end

  # Label for sidebar item. Uses I18n with default: id.humanize
  def sidebar_item_label(id)
    I18n.t("sidebar.#{controller_name}.#{id}", default: id.to_s.humanize)
  end

  # Path for sidebar item. Must be implemented by the including controller.
  def sidebar_item_path(id)
    raise NotImplementedError, "#{self.class} must implement sidebar_item_path(id)"
  end
end
