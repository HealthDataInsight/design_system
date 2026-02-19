# frozen_string_literal: true

# Controller concern: build sidebar content in before_action (like navigation_items).
# Layout renders controller.sidebar_sections via shared/_sidebar_navigation.html.erb
# Reusable for any sidebar content; each controller sets its own sections in before_action.
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

  # Label for sidebar item. Override sidebar_label_scope to use e.g. "sidebar.pages".
  def sidebar_item_label(id)
    I18n.t("sidebar.#{self.class.name.underscore}.#{id}", default: id.to_s.humanize)
  end

  def sidebar_item_path(id)
    send("#{id}_path")
  end
end
