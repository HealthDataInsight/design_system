module DesignSystem
  module Components
    module Nhsuk
      # This concern is used to provide GOVUK Table.
      module Table
        extend ActiveSupport::Concern

        private

        ## <thead>
        def table_heading(headings: [])
          content_tag(:thead, role: 'rowgroup', class: "#{brand}-table__head") do
            content_tag(:tr, role: 'row') do
              headings.each_with_object(ActiveSupport::SafeBuffer.new) do |heading, safe_buffer|
                safe_buffer.concat(content_tag(:th, heading, scope: 'col', class: '', role: 'columnheader'))
              end
            end
          end
        end

        ## <tbody><tr>
        def content_for_row(row)
          content_tag(:tr, nil, class: "#{brand}-table__row") do
            row.each_with_object(ActiveSupport::SafeBuffer.new) do |col, safe_buffer|
              safe_buffer.concat(content_tag(:td, col, class: "#{brand}-table__cell"))
            end
          end
        end

        def content_for_numeric_row(row)
          content_for_row(row)
        end
      end
    end
  end
end
