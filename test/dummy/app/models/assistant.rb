# This is a demonstration class for testing the design system.
class Assistant < ApplicationRecord
  Filling = Struct.new(:id, :title, :description)
  Colour = Struct.new(:id, :title, :description)

  FILLINGS = [
    Filling.new('pastrami', 'Pastrami', 'Brined, smoked, steamed and seasoned'),
    Filling.new('cheddar', 'Cheddar', 'A sharp, off-white natural cheese')
  ].freeze

  COLOURS = [
    Colour.new('red', 'Red', 'Roses are red'),
    Colour.new('blue', 'Blue', 'Violets are... purple?')
  ].freeze

  serialize :desired_filling, coder: YAML

  # Rails now adds presence validation to associations automatically but usually govuk-form-builder set relationships by assigning values to the foreign key column.
  # This results in errors being added to the object on attributes that do not appear in the form, for example on department instead of department_id.
  # You can suppress this behaviour by adding optional: true to the relationship and manually adding the presence validation to the foreign key field yourself.
  belongs_to :department, optional: true
  belongs_to :role, optional: true

  validates :age,
            presence: { message: 'Enter an age' },
            numericality: { greater_than_or_equal_to: 0, message: 'Age must be greater than 0' }
  validates :colour,
            presence: { message: 'Select a colour' }
  validates :description,
            presence: { message: 'Enter a description' }
  validates :lunch_option,
            presence: { message: 'Select a lunch option' }
  validates :password,
            presence: { message: 'Enter a password' },
            length: { minimum: 8, message: 'Password must be longer than 8 characters' }
  validates :terms_agreed,
            acceptance: { message: 'You must agree to the terms and conditions' }
  validates :title,
            presence: { message: 'Enter a title' },
            length: { minimum: 2, message: 'Title should be longer than 1' }
  validates :website,
            presence: { message: 'Enter a website' },
            format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: 'Enter a valid website' }

  validates :department_id, presence: { message: 'Select a department' }
  validates :role_id, presence: { message: 'Select at least one role' }

  validate :dob_must_be_in_the_past, if: -> { date_of_birth.present? }
  validate :must_select_at_least_one_filling
  validate :phone_or_email_exists

  private

  def phone_or_email_exists
    return unless phone.blank? && email.blank?

    errors.add(:base, 'Enter a telephone number or email address')
  end

  def must_select_at_least_one_filling
    return unless desired_filling.blank? || desired_filling.reject(&:blank?).empty?

    errors.add(:desired_filling, 'Select at least one filling')
  end

  def dob_must_be_in_the_past
    errors.add(:date_of_birth, 'Your date of birth must be in the past') unless date_of_birth < Date.today
  end

  # TODO: single field error highlighting issue
  # def year_of_birth_must_be_1900_or_later
  #   errors.add(:date_of_birth_year, 'Year of birth must be 1900 or later') unless date_of_birth.year > 1900
  # end
end
