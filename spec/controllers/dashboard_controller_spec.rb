# frozen_string_literal: true

require 'rails_helper'
require_relative '../login_module'

RSpec.describe(DashboardsController, type: :controller) do
  login
  describe 'AnnouncementLike' do
    user = User.create_with(uin: '111222333',
                            first_name: 'Tryston', last_name: 'Burriola',
                            email: 'trystonburriola@tamu.edu', phone: '5125952682',
                            password: 'password', isActive: true, role: 1, classify: 1).find_or_create_by!(email: 'trystonburriola@tamu.edu')

    announcement = Announcement.create_with(title: 'testerAnnouncement',
                                            description: 'This is the test description.').find_or_create_by!(title: 'testerAnnouncement')

    ua = UserAnnouncement.find_by(user_id: user.id, announcement_id: announcement.id)

    ua&.destroy

    # Rainy
    it 'no user param' do
      expect(UserAnnouncement.find_by(user_id: user.id, announcement_id: announcement.id)).to eq(nil)
      get :like, params: { user_id: nil, announcement_id: announcement.id }
      expect(controller.params[:user_id]).to eq('')
      expect(controller.params[:announcement_id]).not_to eq(nil)
      expect(UserAnnouncement.find_by(user_id: user.id, announcement_id: announcement.id)).to eq(nil)
    end

    it 'no announcement param' do
      expect(UserAnnouncement.find_by(user_id: user.id, announcement_id: announcement.id)).to eq(nil)
      get :like, params: { user_id: user.id, announcement_id: nil }
      expect(controller.params[:user_id]).not_to eq(nil)
      expect(controller.params[:announcement_id]).to eq('')
      expect(UserAnnouncement.find_by(user_id: user.id, announcement_id: announcement.id)).to eq(nil)
    end

    # Sunny
    it 'creates UserAnnouncement join through get route' do
      expect(UserAnnouncement.find_by(user_id: user.id, announcement_id: announcement.id)).to eq(nil)
      get :like, params: { user_id: user.id, announcement_id: announcement.id }
      expect(controller.params[:user_id]).not_to eq(nil)
      expect(controller.params[:announcement_id]).not_to eq(nil)
      expect(UserAnnouncement.find_by(user_id: user.id, announcement_id: announcement.id)).not_to eq(nil)
    end

    it 'destroys UserAnnouncement join through get route' do
      UserAnnouncement.create(user_id: user.id, announcement_id: announcement.id)
      expect(UserAnnouncement.find_by(user_id: user.id, announcement_id: announcement.id)).not_to eq(nil)
      get :like, params: { user_id: user.id, announcement_id: announcement.id }
      expect(controller.params[:user_id]).not_to eq(nil)
      expect(controller.params[:announcement_id]).not_to eq(nil)
      expect(UserAnnouncement.find_by(user_id: user.id, announcement_id: announcement.id)).to eq(nil)
    end
  end
end
