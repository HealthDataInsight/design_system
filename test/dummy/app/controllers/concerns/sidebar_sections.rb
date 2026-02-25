# frozen_string_literal: true

# Controller concern: build sidebar content in before_action (like navigation_items).
# Layout renders controller.sidebar_sections via shared/_sidebar_navigation.html.erb
#
# Usage: define SIDEBAR_CONTENT constant, implement sidebar_item_path(id), then:
#   set_sidebar_sections => build_sidebar_from_sections(SIDEBAR_CONTENT)
module SidebarSections
  # TODO: sidebar layout should be hidden with js for small screens
  # .app-pane {
  #   display: block;
  # }
  # .app-pane__side-bar {
  #   display: none; /* hidden on small screens */
  # }
  # @media (min-width: 64rem) {
  #   .app-pane {
  #     display: grid;
  #     grid-template-columns: 280px minmax(0, 1fr); /* sidebar + main */
  #     column-gap: 2rem;
  #   }

  #   .app-pane__side-bar {
  #     display: block;      /* only appears from this breakpoint up */
  #     align-self: start;   /* sticks to top of the column */
  #   }
  # }
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
    sections.each { |section| add_sidebar_section(section[:heading], sidebar_items_for(section[:items])) }
  end

  def sidebar_items_for(ids)
    ids.map { |id| [sidebar_item_label(id), sidebar_item_path(id)] }
  end

  # Label for sidebar item. Uses I18n with default: id.humanize
  def sidebar_item_label(id)
    I18n.t("sidebar.#{controller_name}.#{id}", default: id.to_s.humanize)
  end

  # Path for sidebar item. Must be implemented by the including controller.
  def sidebar_item_path(_id)
    raise NotImplementedError, "#{self.class} must implement sidebar_item_path(id)"
  end
end
