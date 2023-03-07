class UsersController < ApplicationController
  before_action :authorize_user, except: [:new, :create]
  before_action :unique_user, only: [:new]
  helper_method :sort_column, :sort_direction
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    # Search bar
    @per_page = params[:per_page] || User.per_page || 10
    if params[:search]
      # Able to search for first, last or both (where)
      # Paginate splits table (paginate)
      @users = User.order(sort_column + " " + sort_direction).where("CONCAT_WS(' ', first_name, last_name) ILIKE ?", "%#{params[:search].strip.downcase}%").paginate( :per_page => @per_page, :page => params[:page])
    else
      @users = User.order(sort_column + " " + sort_direction).paginate( :per_page => @per_page, :page => params[:page])
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(new_user_params)
    @user.email = current_admin.email
    @user.password = current_admin.uid
    @user.role = "0"

    #Don't allow duplicate user creation (Unique user per email)
    if(User.find_by(email: @user.email))
      puts("USER EXISTS!") #Show error here
    #DEBUG
    # puts("USER CLASSIFY: " + @user.classify.to_s)
    else
      respond_to do |format|
        if @user.save
          @error = false
          format.html { redirect_to users_path, notice: "User was successfully created." }
          format.json { render :show, status: :created, location: @user }
        else
          puts(@user.errors.inspect)
          @error = true
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "first_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :uin, :email, :phone, :password, :classify, :isActive, :role, event_ids: [])
  end

  #Select only non-default values from new user creation
  def new_user_params
    params.require(:user).permit(:first_name, :last_name, :uin, :phone, :classify)
  end

  # Verify User has created thier profile. Redirect to create profile if not
  def authorize_user
    if User.find_by(email: current_admin.email) == nil
      redirect_to :controller => 'users', :action => 'new'
    end
  end

  #Only allow unique users to visit the create profile page
  def unique_user
    if User.find_by(email: current_admin.email) != nil
      redirect_to :controller => 'users', :action => 'index'
    end
  end

end