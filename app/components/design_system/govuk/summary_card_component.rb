module DesignSystem
  module Govuk
    # GOV.UK summary card: uses the summary-card block names and the
    # govuk-visually-hidden class for action suffixes.
    class SummaryCardComponent < DesignSystem::Generic::SummaryCardComponent
      private

      def title_class
        "#{brand}-summary-card__title"
      end

      def visually_hidden_class
        "#{brand}-visually-hidden"
      end
    end
  end
end
