module DemoCollections
  extend ActiveSupport::Concern

  private

  def fillings
    [
      OpenStruct.new(id: 'pastrami', name: 'Pastrami', description: 'Brined, smoked, steamed and seasoned'),
      OpenStruct.new(id: 'cheddar', name: 'Cheddar', description: 'A sharp, off-white natural cheese')
    ]
  end
end 