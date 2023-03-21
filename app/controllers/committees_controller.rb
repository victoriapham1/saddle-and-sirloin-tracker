class CommitteesController < ApplicationController
  before_action :authorize_user
  before_action :set_committee, only: %i[show edit update destroy]

  def index
    @committees = Committee.all
  end

  def new
    @committee = Committee.new
  end

  def show
    @committee = Committee.find(params[:id])
  end

  def edit
    @committee = Committee.find(params[:id])
  end

  def create
    @committee = Committee.new(committee_params)

    respond_to do |format|
      if @committee.save
        format.html { redirect_to(committees_path, notice: 'Committee was successfully created.') }
        format.json { render(:show, status: :created, location: @committee) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @committee.errors, status: :unprocessable_entity) }
      end
    end
  end

  def update
    respond_to do |format|
      if @committee.update(committee_params)
        format.html { redirect_to(committees_path, notice: 'Committee was successfully updated.') }
        format.json { render(:show, status: :ok, location: @committee) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @committee.errors, status: :unprocessable_entity) }
      end
    end
  end

  def delete
    @committee = Committee.find(params[:id])
  end

  def destroy
    @committee = Committee.find(params[:id])
    @committee.destroy
    redirect_to(committees_path, notice: 'Committee was successfully deleted.')
  end

  private

  def set_committee
    @committee = Committee.find(params[:id])
  end

  def committee_params
    params.require(:committee).permit(:committee_name, :description)
  end

  # Verify User has created thier profile. Redirect to create profile if not
  def authorize_user
    redirect_to(controller: 'users', action: 'new') if User.find_by(email: current_admin.email).nil?
  end
end
