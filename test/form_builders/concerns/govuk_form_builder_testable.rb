# This concern manages choosing the relevant layout for our given design system
module GovukFormBuilderTestable
  extend ActiveSupport::Concern

  included do
    test 'self.brand' do
      assert_equal @brand, @builder.brand
    end
  end
end
