# This is a demonstration class for testing the design system.
class Assistant < ApplicationRecord
  Filling = Struct.new(:id, :name, :description)
  Colour = Struct.new(:id, :title, :description)

  FILLINGS = [
    Filling.new('pastrami', 'Pastrami', 'Brined, smoked, steamed and seasoned'),
    Filling.new('cheddar', 'Cheddar', 'A sharp, off-white natural cheese')
  ].freeze

  COLOURS = [
    Colour.new('red', 'Red', 'Roses are red'),
    Colour.new('blue', 'Blue', 'Violets are... purple?')
  ].freeze

  # Rails now adds presence validation to associations automatically but usually govuk-form-builder set relationships by assigning values to the foreign key column.
  # This results in errors being added to the object on attributes that do not appear in the form, for example on department instead of department_id.
  # You can suppress this behaviour by adding optional: true to the relationship and manually adding the presence validation to the foreign key field yourself.
  belongs_to :department, optional: true
  belongs_to :role, optional: true

  validates :title,
            presence: { message: 'Enter a title' },
            length: { minimum: 2, message: 'Title should be longer than 1' }
  validates :password,
            presence: { message: 'Enter a password' },
            length: { minimum: 8, message: 'Password must be longer than 8 characters' }

  validates :department_id, presence: { message: 'Select a department' }
  validates :role_id, presence: { message: 'Select at least one role' }

  validate :dob_must_be_in_the_past, if: -> { date_of_birth.present? }
  validate :phone_or_email_exists

  private

  def phone_or_email_exists
    return unless phone.blank? && email.blank?

    errors.add(:email, 'Enter a telephone number or email address')
  end

  def dob_must_be_in_the_past
    errors.add(:date_of_birth, 'Your date of birth must be in the past') unless date_of_birth < Date.today
  end
end
