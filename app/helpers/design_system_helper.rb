# frozen_string_literal: true

# The helpers for the design system
module DesignSystemHelper
  include ActionView::Helpers::FormHelper

  def brand
    controller.send(:brand)
  end

  # This method provides access to the current design system adapter
  def ds_fixed_elements
    instance = DesignSystem::Registry.builder(brand, 'fixed_elements', self)

    if block_given?
      yield instance

      instance.render
    else
      instance
    end
  end

  def ds_form_builder
    DesignSystem::Registry.form_builder(brand)
  end

  def ds_form_with(model: nil, scope: nil, url: nil, format: nil, **options, &)
    form_with(model:, scope:, url:, format:, builder: ds_form_builder, **options, &)
  end

  def ds_render_template(design_system_layout = 'application')
    @design_system_layout = design_system_layout
    render(template: "layouts/#{brand}/#{design_system_layout}")
  end

  def ds_table(options = {}, &block)
    raise ArgumentError unless block_given?

    table = ::DesignSystem::Components::Table.new
    block.call(table)
    render ::DesignSystem::Registry.component(brand, :table).new(table:, **options)
  end

  def ds_summary_list(&block)
    raise ArgumentError unless block_given?

    summary_list = ::DesignSystem::Components::SummaryList.new
    block.call(summary_list)
    render ::DesignSystem::Registry.component(brand, :summary_list).new(summary_list:)
  end

  def ds_tab(&block)
    raise ArgumentError unless block_given?

    tab = ::DesignSystem::Components::Tab.new(self)
    block.call(tab)
    render ::DesignSystem::Registry.component(brand, :tab).new(tab:)
  end

  def ds_start_button(text, href = '#', options = {})
    render DesignSystem::Registry.component(brand, :start_button).new(text, href, options)
  end

  def ds_button_tag(content_or_options = nil, options = nil, &block)
    component = DesignSystem::Registry.component(brand, :button).new(content_or_options, options)
    render(component) { block ? capture(&block) : nil }
  end

  def ds_link_to(name = nil, options = nil, html_options = nil, &block)
    klass = DesignSystem::Registry.component(brand, :link)
    component = klass.new(name, options, html_options, link_context: @link_context)
    render(component) { block ? capture(&block) : nil }
  end

  def ds_pagination(collection = nil, options = {})
    defaults = {
      renderer: DesignSystem::Registry.builder(brand, 'pagination_renderer', self),
      previous_label: '&laquo; Previous',
      next_label: 'Next &raquo;'
    }

    will_paginate(collection, defaults.merge!(options))
  end

  def ds_alert(message = nil, &block)
    component = DesignSystem::Registry.component(brand, :alert).new(message)
    render(component) { block ? capture(&block) : nil }
  end

  def ds_notice(message = nil, type: :information, content_heading: { text: nil, tag: :h3 }, &block)
    previous_link_context = @link_context
    @link_context = :notification_banner
    component = DesignSystem::Registry.component(brand, :notification).new(message:, type:, content_heading:)
    render(component) { block ? capture(&block) : nil }
  ensure
    @link_context = previous_link_context
  end

  def ds_heading(text, level: 2, **options)
    render DesignSystem::Registry.component(brand, :heading).new(text, level:, **options)
  end

  def ds_timeago(date, refresh_interval: 60_000, format: :long)
    return if date.blank?

    content = I18n.l(date, format:)

    tag.time(content,
             title: content,
             data: {
               controller: 'timeago',
               timeago_datetime_value: date.iso8601,
               timeago_refresh_interval_value: refresh_interval,
               timeago_add_suffix_value: true
             })
  end

  def ds_panel(title, body)
    render DesignSystem::Registry.component(brand, :panel).new(title:, body:)
  end

  def ds_summary_card(title:, actions: [], &block)
    component = DesignSystem::Registry.component(brand, :summary_card).new(title:, actions:)
    render(component) { block ? capture(&block) : nil }
  end

  def ds_callout(label, body)
    render DesignSystem::Registry.component(brand, :callout).new(label:, body:)
  end

  def ds_details(summary_text, &block)
    raise ArgumentError unless block_given?

    component = DesignSystem::Registry.component(brand, :details).new(summary_text)
    render(component) { capture(&block) }
  end

  def ds_action_link(name = nil, options = nil, html_options = nil)
    render DesignSystem::Registry.component(brand, :action_link).new(name, options, html_options)
  end

  def ds_grid(options = {}, &block)
    raise ArgumentError unless block_given?

    grid = ::DesignSystem::Components::Grid.new
    block.call(grid)
    render ::DesignSystem::Registry.component(brand, :grid).new(grid:, **options)
  end

  def ds_paragraph(text = nil, size: nil, **options, &block)
    component = DesignSystem::Registry.component(brand, :paragraph).new(text:, size:, **options)
    render(component) { block ? capture(&block) : nil }
  end

  def ds_list(type: :default, **options, &block)
    raise ArgumentError, 'block required' unless block_given?

    list_data = ::DesignSystem::Components::List.new
    block.call(list_data)
    render ::DesignSystem::Registry.component(brand, :list).new(list: list_data, type:, **options)
  end

  def ds_inset_text(text = nil, **options, &block)
    component = DesignSystem::Registry.component(brand, :inset_text).new(text:, **options)
    output = if block
               render(component) { capture(&block) }
             else
               render(component)
             end
    output.presence
  end

  def ds_code(code, language)
    DesignSystem::Registry.builder(brand, 'code', self).render_code(code, language)
  end
end
