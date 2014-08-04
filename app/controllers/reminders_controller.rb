class RemindersController < ApplicationController

  before_action :set_reminder_id, only: [:update]
  before_action :set_reminder_name, only: [ :show, :edit, :destroy]

  # GET /reminders
  # GET /reminders.json
  def index
    @trip = Trip.find_by_name(params[:trip_id])
    @folder = @trip.folders.find_by_name(params[:folder_id])
    @reminders = @folder.reminders
    if request.headers['X-PJAX']
      render :layout => false
    else
      render :layout => "folder"
    end
  end

  # GET /reminders/1
  # GET /reminders/1.json
  def show
  end

  # GET /reminders/new
  def new
    @trip = Trip.find_by_name(params[:trip_id])
    @folder = @trip.folders.find_by_name(params[:folder_id])
    @reminder = Reminder.new
  end

  # GET /reminders/1/edit
  def edit
  end

  # POST /reminders
  # POST /reminders.json
  def create
    @trip = Trip.find_by_id(params[:trip_id])
    @folder = @trip.folders.find_by_id(params[:folder_id])
    @reminder = @folder.reminders.create(reminder_params)
    if reminder_params[:mode]
      @reminder.create_activity key: 'Created Reminder', owner: @folder
    end
    respond_to do |format|
      if @reminder.save
        format.html { redirect_to @reminder, notice: 'Reminder was successfully created.' }
        format.json { render :show, status: :created, location: @reminder }
      else
        format.html { render :new }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reminders/1
  # PATCH/PUT /reminders/1.json
  def update
    if reminder_params[:mode]
      @reminder.create_activity key: 'Updated Reminder', owner: @folder
    end
    respond_to do |format|
      if @reminder.update(reminder_params)
        format.html { redirect_to @reminder, notice: 'Reminder was successfully updated.' }
        format.json { render :show, status: :ok, location: @reminder }
      else
        format.html { render :edit }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reminders/1
  # DELETE /reminders/1.json
  def destroy
    @reminder.destroy
    respond_to do |format|
      format.html { redirect_to reminders_url, notice: 'Reminder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

     def set_reminder_name
      @trip = Trip.find_by_name(params[:trip_id])
      @folder = @trip.folders.find_by_name(params[:folder_id]) 
      @reminder = @folder.reminders.find_by_title(params[:id])
      @model_link = "reminder" 
    end

    def set_reminder_id
      @trip = Trip.find_by_id(params[:trip_id])
      @folder = @trip.folders.find_by_id(params[:folder_id]) 
      @reminder = @folder.reminders.find_by_id(params[:id])
      @model_link = "reminder"
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def reminder_params
      params.require(:reminder).permit(:name, :mode, :description, :sent)
    end
end
