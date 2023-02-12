class PollingsController < ApplicationController
  before_action :set_polling, only: %i[ show edit update destroy ]

  # GET /pollings or /pollings.json
  def index
    @pollings = Polling.all
  end

  # GET /pollings/1 or /pollings/1.json
  def show
  end

  # GET /pollings/new
  def new
    @polling = Polling.new
  end

  # GET /pollings/1/edit
  def edit
  end

  # POST /pollings or /pollings.json
  def create
    @polling = Polling.new(polling_params)

    respond_to do |format|
      if @polling.save
        format.html { redirect_to polling_url(@polling), notice: "Polling was successfully created." }
        format.json { render :show, status: :created, location: @polling }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @polling.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pollings/1 or /pollings/1.json
  def update
    respond_to do |format|
      if @polling.update(polling_params)
        format.html { redirect_to polling_url(@polling), notice: "Polling was successfully updated." }
        format.json { render :show, status: :ok, location: @polling }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @polling.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pollings/1 or /pollings/1.json
  def destroy
    @polling.destroy

    respond_to do |format|
      format.html { redirect_to pollings_url, notice: "Polling was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_polling
      @polling = Polling.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def polling_params
      params.require(:polling).permit(:question, :answer1, :answer2, :answer3, :answer4)
    end
end
