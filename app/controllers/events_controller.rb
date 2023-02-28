class EventsController < ApplicationController
      # GET /books or /books.json
  def index
    @events = Event.all
    # @events = Event.search(params[:search])
    @events = Event.search(params[:search], params[:category])
  end

  # GET /books/1 or /books/1.json
  def show
    @event = Event.find(params[:id])
  end

  # GET /books/new
  def new
    @event = Event.new
  end

  # GET /books/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /books or /books.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    @event = Event.find(params[:id])
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    @event = Event.find(params[:id])
  end
  
  # DELETE /books/1 or /books/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path, notice: "Event was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :date, :event_type, :description, :start_time, :end_time, :search)
    end
end
