# frozen_string_literal: true

class AnnouncementsController < ApplicationController
  before_action :authorize_user
  before_action :block_member, except: %i[index show calendar]

  def index
    @announcements = Announcement.all
  end

  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = Announcement.new(announcement_params)
    if @announcement.title === '' || @announcement.description === ''
      flash.alert = 'Invalid input'
      redirect_to(announcements_path)
    elsif @announcement.save
      redirect_to(announcements_path, notice: 'Announcement created.')
    else
      # The new action is not being called
      # assign any instance vars needed for the template
      render('new') # just renders the view new
      flash.alert = 'Announcement not found.'
    end
  end

  def edit
    @announcement = Announcement.find(params[:id])
  end

  def update
    @announcement = Announcement.find(params[:id])
    if @announcement.update(announcement_params)
      redirect_to(announcement_path(@announcement), notice: 'Announcement updated.')
    else
      render('edit')
      flash.alert = 'Announcement not found.'
    end
  end

  def show
    @announcement = Announcement.find(params[:id])
  end

  def delete
    @announcement = Announcement.find(params[:id])
  end

  def destroy
    @announcement = Announcement.find(params[:id])
    @announcement.destroy
    redirect_to(announcements_path, notice: 'Announcement was successfully destroyed.')
  end

  def calendar; end

  private

  def announcement_params
    params.require(:announcement).permit(:title, :description)
  end

  def authorize_user
    user = User.find_by(email: current_admin.email)
    if user.nil?
      redirect_to(controller: 'users', action: 'new')
    elsif user.isActive == false
      redirect_to(controller: 'users', action: 'waiting')
      user.isRequesting = true
      user.save
    end
  end

  # URL protection: don't allow members to view officer pages/actions
  def block_member
    return unless User.find_by(email: current_admin.email).role.zero?

    redirect_to '/'
  end
end
