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

  def ds_table(options = {}, &)
    raise ArgumentError unless block_given?

    DesignSystem::Registry.builder(brand, 'table', self).render_table(options, &)
  end

  def ds_summary_list(&)
    raise ArgumentError unless block_given?

    DesignSystem::Registry.builder(brand, 'summary_list', self).render_summary_list(&)
  end

  def ds_tab(&)
    raise ArgumentError unless block_given?

    DesignSystem::Registry.builder(brand, 'tab', self).render_tabs(&)
  end

  def ds_start_button(text, href = '#', options = {})
    DesignSystem::Registry.builder(brand, 'button', self).render_start_button(text, href, options)
  end

  def ds_button_tag(content_or_options = nil, options = nil, &)
    DesignSystem::Registry.builder(brand, 'button', self).render_button(content_or_options, options, &)
  end

  def ds_link_to(name = nil, options = nil, html_options = nil, &)
    DesignSystem::Registry.builder(brand, 'link', self).render_link_to(name, options, html_options, &)
  end

  def ds_pagination(collection = nil, options = {})
    defaults = {
      renderer: DesignSystem::Registry.builder(brand, 'pagination_renderer', self),
      previous_label: '&laquo; Previous',
      next_label: 'Next &raquo;'
    }

    will_paginate(collection, defaults.merge!(options))
  end

  def ds_alert(message = nil, &)
    DesignSystem::Registry.builder(brand, 'notification', self).render_alert(message, &)
  end

  def ds_notice(message = nil, header: nil, type: :information, &)
    DesignSystem::Registry.builder(brand, 'notification', self).render_notice(message, header:, type:, &)
  end

  def ds_heading(text, level: 2, **options)
    DesignSystem::Registry.builder(brand, 'heading', self).render_heading(text, level:, **options)
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
    DesignSystem::Registry.builder(brand, 'panel', self).render_panel(title, body)
  end

  def ds_callout(label, body)
    DesignSystem::Registry.builder(brand, 'callout', self).render_callout(label, body)
  end

  def ds_details(summary_text, &)
    raise ArgumentError unless block_given?

    DesignSystem::Registry.builder(brand, 'details', self).render_details(summary_text, &)
  end

  def ds_action_link(name = nil, options = nil, html_options = nil)
    DesignSystem::Registry.builder(brand, 'action_link', self).render_action_link(name, options, html_options)
  end
end
