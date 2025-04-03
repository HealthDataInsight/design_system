# This is a demonstration class for testing the design system.
class Assistant < ApplicationRecord
  COLOURS = [
    { id: 'red', title: 'Red', description: 'Roses are red' },
    { id: 'blue', title: 'Blue', description: 'Violets are.. purple?' }
  ].freeze

  FILLINGS = [
    { id: 'pastrami', name: 'Pastrami', description: 'Brined, smoked, steamed and seasoned' },
    { id: 'cheddar', name: 'Cheddar', description: 'A sharp, off-white natural cheese' }
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

  validates :desired_filling, presence: { message: 'Select a desired filling' }
  validates :lunch_option, presence: { message: 'Select a lunch option' }
  validates :terms_agreed, presence: { message: 'Read and agree to the terms' }
  validates :colour, presence: { message: 'Choose a favourite colour' }
  validate :year_of_birth_must_be_1900_or_later, if: -> { date_of_birth.present? }

  private

  def phone_or_email_exists
    return unless phone.blank? && email.blank?

    errors.add(:base, 'Enter a telephone number or email address')
  end

  def dob_must_be_in_the_past
    errors.add(:date_of_birth, 'Your date of birth must be in the past') unless date_of_birth < Date.today
  end
end
