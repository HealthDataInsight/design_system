# frozen_string_literal: true

require 'design_system/registry'

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

  def ds_render_template(design_system_layout = 'application')
    @design_system_layout = design_system_layout
    render(template: "layouts/#{brand}/#{design_system_layout}")
  end

  def ds_table(&)
    raise ArgumentError unless block_given?

    DesignSystem::Registry.builder(brand, 'table', self).render_table(&)
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

  def ds_pagination(collection = nil, options = {})
    defaults = {
      renderer: DesignSystem::Registry.builder(brand, 'pagination_renderer', self),
      previous_label: '&laquo; Previous',
      next_label: 'Next &raquo;'
    }

    will_paginate(collection, defaults.merge!(options))
  end

  def ds_alert(message)
    DesignSystem::Registry.builder(brand, 'notification', self).render_alert(message)
  end

  def ds_notice(message)
    DesignSystem::Registry.builder(brand, 'notification', self).render_notice(message)
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
end
