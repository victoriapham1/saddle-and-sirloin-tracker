# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Announcement, type: :model) do
  context 'validation tests' do
    
    # Rainy
    it 'ensures announcement title' do
      ann = Announcement.new(description: 'This is the description!').save
      expect(ann).to(eq(false))
    end

    it 'ensures announcement description' do
      ann = Announcement.new(title: 'This is the title!').save
      expect(ann).to(eq(false))
    end

    # Sunny
    it 'valid test' do
      ann = Announcement.new(title: 'This is the title!', description: 'This is the description!').save
      expect(ann).to(eq(true))
    end
  end
end
