# frozen_string_literal: true

require 'rails_helper'
require_relative '../login_module'

RSpec.describe('Announcements', type: :feature) do
  test = Announcement.create_with(title: 'Rspec', description: 'Description!').find_or_create_by(title: 'Rspec')

  # Members should NOT have these options + validate calendar elem
  describe('US 61/62/32: Officer only announcement CRUD[rainy]') do
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
  describe('US 61/62/32: Officer only announcement CRUD[sunny]') do
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

  # Vice President SHOULD have these options + validate calendar elem
  describe('US 61/62/32: VP announcement CRUD[sunny]') do
    vp_login
    it 'shows crud routes for officer and show calendar' do
      visit root_path
      expect(page).to have_css('#calendar')
      expect(page).to have_content(test.title)
      expect(page).to have_link(href: new_announcement_path)
      expect(page).to have_link(href: edit_announcement_path(test.id))
      expect(page).to have_link(href: delete_announcement_path(test.id))
    end
  end

  # President SHOULD have these options + validate calendar elem
  describe('US 61/62: Pres announcement CRUD[sunny]') do
    p_login
    it 'shows crud routes for officer and show calendar' do
      visit root_path
      expect(page).to have_css('#calendar')
      expect(page).to have_content(test.title)
      expect(page).to have_link(href: new_announcement_path)
      expect(page).to have_link(href: edit_announcement_path(test.id))
      expect(page).to have_link(href: delete_announcement_path(test.id))
    end
  end

  describe('US 6: Create announcement') do
    login
    it 'Throws error on missing title' do
      visit new_announcement_path
      expect(page).to have_content('Title')
      expect(page).to have_content('Description')
      fill_in 'announcement[description]', with: 'Description.'
      click_on 'Submit'
      expect(page).to have_content('error')
    end
    it 'Throws error on missing description' do
      visit new_announcement_path
      expect(page).to have_content('Title')
      expect(page).to have_content('Description')
      fill_in 'announcement[title]', with: 'Test Announcement'
      click_on 'Submit'
      expect(page).to have_content('error')
    end
    it 'Fill out form' do
      visit new_announcement_path
      expect(page).to have_content('Title')
      expect(page).to have_content('Description')
      fill_in 'announcement[title]', with: 'Test Announcement'
      fill_in 'announcement[description]', with: 'Description.'
      click_on 'Submit'
      expect(page).to have_content('Test Announcement')
    end
  end

  describe('US 9: Update announcement') do
    login
    it 'Throws error on empty title' do
      visit edit_announcement_path(test.id)
      expect(page).to have_content('Title')
      expect(page).to have_content('Description')
      expect(page).to have_content('Description!')
      fill_in 'announcement[title]', with: ''
      fill_in 'announcement[description]', with: 'Description.'
      click_on 'Submit'
      expect(page).to have_content('error')
    end

    it 'Throws error on empty description' do
      visit edit_announcement_path(test.id)
      expect(page).to have_content('Title')
      expect(page).to have_content('Description')
      expect(page).to have_content('Description!')
      fill_in 'announcement[title]', with: 'Test Announcement'
      fill_in 'announcement[description]', with: ''
      click_on 'Submit'
      expect(page).to have_content('error')
    end

    it 'Edit announcement form' do
      visit edit_announcement_path(test.id)
      expect(page).to have_content('Title')
      expect(page).to have_content('Description')
      expect(page).to have_content('Description!')
      fill_in 'announcement[title]', with: 'Test Announcement'
      fill_in 'announcement[description]', with: 'Description.'
      click_on 'Submit'
      expect(page).to have_content('Test Announcement')
    end
  end

  describe('US 13: Delete announcement') do
    login
    it 'Deletes announcement' do
      visit root_path
      expect(page).to have_content('Rspec')
      visit delete_announcement_path(test.id)
      expect(page).not_to have_content('Rspec')
    end
  end
end
