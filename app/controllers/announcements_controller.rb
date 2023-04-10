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
    respond_to do |format|
      if @announcement.update(announcement_params)
        format.html { redirect_to('/', notice: 'Announcement was successfully created.') }
        format.json { render(:show, status: :ok, location: @announcement) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @announcement.errors, status: :unprocessable_entity) }
      end
    end
  end

  def edit
    @announcement = Announcement.find(params[:id])
  end

  def update
    @announcement = Announcement.find(params[:id])
    respond_to do |format|
      if @announcement.update(announcement_params)
        format.html { redirect_to('/', notice: 'Announcement was successfully updated.') }
        format.json { render(:show, status: :ok, location: @announcement) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @announcement.errors, status: :unprocessable_entity) }
      end
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
    redirect_to('/', notice: 'Announcement was deleted.')
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
