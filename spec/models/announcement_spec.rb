require 'rails_helper'

RSpec.describe(Announcement, type: :model) do
  context 'validation tests' do
    it 'ensures announcement title' do
      ann = Announcement.new(description: 'This is the description!').save
      expect(ann).to(eq(false))
    end

    it 'ensures announcement description' do
      ann = Announcement.new(description: 'This is the description!').save
      expect(ann).to(eq(false))
    end
  end
end
