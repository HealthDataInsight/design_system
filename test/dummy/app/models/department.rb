class Department < ApplicationRecord
  has_many :assistants

  validates :title, presence: true
end
