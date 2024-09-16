# This is a demonstration class for testing the design system.
class Assistant < ApplicationRecord
  belongs_to :department

  validates :title, presence: true
end
