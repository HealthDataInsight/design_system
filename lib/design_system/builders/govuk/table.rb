module DesignSystem
  module Builders
    module Govuk
      # This concern is used to provide GOVUK Table.
      module Table
        extend ActiveSupport::Concern

        private

        def table_heading(headings: [])
          content_tag(:thead, class: "#{brand}-table__head") do
            content_tag(:tr, class: "#{brand}-table__row") do
              headings.each_with_object(ActiveSupport::SafeBuffer.new) do |heading, safe_buffer|
                safe_buffer.concat(content_tag(:th, heading, scope: 'col', class: "#{brand}-table__header"))
              end
            end
          end
        end

        def content_for_row(row)
          content_tag(:tr, nil, class: "#{brand}-table__row") do
            row.each_with_object(ActiveSupport::SafeBuffer.new).with_index do |(col, safe_buffer), i|
              if i.zero?
                safe_buffer.concat(content_tag(:th, col, scope: 'row', class: "#{brand}-table__header"))
              else
                safe_buffer.concat(content_tag(:td, col, class: "#{brand}-table__cell"))
              end
            end
          end
        end

        def content_for_numeric_row(row)
          content_tag(:tr, nil, class: "#{brand}-table__row") do
            row.each_with_object(ActiveSupport::SafeBuffer.new).with_index do |(col, safe_buffer), i|
              if i.zero?
                safe_buffer.concat(
                  content_tag(:th, col, scope: 'row',
                                        class: "#{brand}-table__header #{brand}-table__header--numeric")
                )
              else
                safe_buffer.concat(content_tag(:td, col, class: "#{brand}-table__cell #{brand}-table__cell--numeric"))
              end
            end
          end
        end
      end
    end
  end
end
