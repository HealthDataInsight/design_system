# This is a demonstration class for testing the design system.
class Assistant < ApplicationRecord
  # Rails now adds presence validation to associations automatically but usually govuk-form-builder set relationships by assigning values to the foreign key column.
  # This results in errors being added to the object on attributes that do not appear in the form, for example on department instead of department_id.
  # You can suppress this behaviour by adding optional: true to the relationship and manually adding the presence validation to the foreign key field yourself.
  belongs_to :department, optional: true
  belongs_to :role, optional: true
  belongs_to :office, optional: true
  has_one_attached :cv

  validates :title, presence: true
  validates :date_of_birth, presence: true
  validates :description, presence: true
  validates :terms_agreed, presence: true
  validates :lunch_option, presence: true

  validates :department_id, presence: true
  validates :role_id, presence: true
  validates :office_id, presence: true
  # validates :cv, attached: true, content_type: ['application/pdf'], size: { less_than: 5.megabytes }
end
