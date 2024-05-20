# This is a demonstration class for testing the design system.
class Assistant < ApplicationRecord
  validates :title, presence: true

  # TODO: This needs to be replaced by a propper lookup and/or association
  def departments
    dept_struct = Struct.new(:id, :name)
    [] << dept_struct.new(1, 'Sales') << dept_struct.new(2, 'Marketing') << dept_struct.new(3, 'Finance')
  end

  # TODO: This needs to be replaced by a propper lookup and/or association
  def assistant_ids
    [1, 2, 3]
  end
end
