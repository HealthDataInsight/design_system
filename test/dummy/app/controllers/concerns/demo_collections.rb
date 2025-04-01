module DemoCollections
  extend ActiveSupport::Concern

  private

  def fillings
    [
      OpenStruct.new(id: 'pastrami', name: 'Pastrami', description: 'Brined, smoked, steamed and seasoned'),
      OpenStruct.new(id: 'cheddar', name: 'Cheddar', description: 'A sharp, off-white natural cheese')
    ]
  end

  def colours
    [
      OpenStruct.new(id: 'red', title: 'Red', description: 'Roses are red'),
      OpenStruct.new(id: 'blue', title: 'Blue', description: 'Violets are.. purple?')
    ]
  end
end
