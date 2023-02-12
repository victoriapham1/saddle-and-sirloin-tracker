class AnnouncementsController < ApplicationController
  def index
    @announcements = Announcement.all
  end

  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = Announcement.new(announcement_params)
    if @announcement.title === "" || @announcement.description === ""
      flash.alert = "Invalid input"
      redirect_to announcements_path
    else
      if @announcement.save
        redirect_to announcements_path, notice: "Announcement created."
      else
        #The new action is not being called
        #assign any instance vars needed for the template
        render('new') #just renders the view new
        flash.alert = "Announcement not found."
      end
    end
  end

  def edit
    @announcement = Announcement.find(params[:id])
  end

  def update
    @announcement = Announcement.find(params[:id])
    if @announcement.update(announcement_params)
      redirect_to announcement_path(@announcement), notice: "Announcement updated."
    else
      render('edit')
      flash.alert = "Announcement not found."
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
    redirect_to announcements_path, notice: "Announcement was successfully destroyed."
  end

  def calendar
  end

  private
    def announcement_params
      params.require(:announcement).permit(:title, :description)
    end

end
