# frozen_string_literal: true

require 'rails_helper'
require_relative '../login_module'

RSpec.describe('Announcements', type: :feature) do
    test = Announcement.create_with(title: "Rspec", description: "Description!").find_or_create_by(title: "Rspec")

    # Members should NOT have these options + validate calendar elem
    describe('US 61/62: Officer only announcement CRUD[rainy]') do
        member_login
        it 'blocks crud routes for member and show calendar' do
            visit root_path
            expect(page).to have_css('#calendar')
            expect(page).to have_content(test.title)
            expect(page).not_to have_link(href: new_announcement_path)
            expect(page).not_to have_link(href: edit_announcement_path(test.id))
            expect(page).not_to have_link(href: delete_announcement_path(test.id))
        end
    end

    # Officers SHOULD have these options + validate calendar elem
    describe('US 61/62: Officer only announcement CRUD[sunny]') do
        login
        it 'shows crud routes for officer and show calendar' do
            visit root_path
            expect(page).to have_css('#calendar')
            expect(page).to have_content(test.title)
            expect(page).to have_link(href: new_announcement_path)
            expect(page).to have_link(href: edit_announcement_path(test.id))
            expect(page).to have_link(href: delete_announcement_path(test.id))
        end
    end
end