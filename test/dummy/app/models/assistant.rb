# This is a demonstration class for testing the design system.
class Assistant < ApplicationRecord
  belongs_to :department
  has_many :features

  validates :title, presence: true
end
