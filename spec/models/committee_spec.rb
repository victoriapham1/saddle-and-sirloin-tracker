require 'rails_helper'

RSpec.describe(Committee, type: :model) do
  context 'validation tests' do
    # Rainy: This test will determine that missing attritubtes (description) will fail.
    it 'ensures committee description must be present' do
      com = Committee.new(committee_name: 'IM Committee').save
      expect(com).to(eq(false))
    end

    # Rainy: This test will determine that missing attritubtes (name) will fail.
    it 'ensures committee name must be present' do
      com = Committee.new(description: 'Organize team sport competitions').save
      expect(com).to(eq(false))
    end

    # Sunny test: This test will determime that all attributes must be present.
    it 'ensures all attributes must be present' do
      com = Committee.new(committee_name: 'IM Committee', description: 'Organize sport teams.').save
      expect(com).to(eq(true))
    end
  end
end
