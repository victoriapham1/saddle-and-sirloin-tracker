class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction
  def index
    @users = User.order(sort_column + " " + sort_direction)
  end

  def new
  end

  def edit
  end

  private
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "first_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
