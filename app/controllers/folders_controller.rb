
class FoldersController < ApplicationController
  before_action :set_folder_id, only: [:update]
  before_action :set_folder_name, only: [:edit, :destroy]

  # GET /folders
  # GET /folders.json
  def index
    @trip = Trip.find_by_name(params[:trip_id])
  end

  # GET /folders/1
  # GET /folders/1.json
  def show
    @trip = Trip.find_by_name(params[:trip_id])
    @folder = @trip.folders.find_by_name(params[:id])
    if request.headers['X-PJAX']
      render :layout => false
    else
      render :layout => "folder"
    end
  end

  # GET /folders/new
  def new
    Rails.logger.debug ">>> The value of the params is #{params.inspect} "
    @trip = Trip.find_by_name(params[:trip_id])
    @folder = Folder.new
    respond_to do |format|
      format.html { render :layout => false }
    end
  end


  def activity
    @trip = Trip.find_by_name(params[:trip_id])
    @folder = @trip.folders.find_by_name(params[:id])
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_type: "Folder", owner_id: @folder.id, trackable_type: ['Description','Map','Reminder']).all
    if request.headers['X-PJAX']
      render :layout => false
    else
      render :layout => "folder"
    end
  end

  def timeline
    @trip = Trip.find_by_name(params[:trip_id])
    @folder = @trip.folders.find_by_name(params[:id])
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_type: "Folder", owner_id: @folder.id, trackable_type: ['Description','Map','Reminder']).all
    Rails.logger.debug "The valuebo f hte activities is #{@activities.inspect}"
    custom_timeline = {};
    timeline_main = {
      "headline"=> "Trip to #{@trip.name} - #{@folder.name} Timeline",
      "type"=> "default",
      "text"=> "#{@trip.description}"
    }
    activity_timeline = [];
    @activities.each do |activity|
      my_model=activity.trackable_type.classify.constantize.find_by_id(activity.trackable_id)
        activity_timeline.push({
            "startDate" => my_model.created_at,
            "endDate" => my_model.updated_at,
            "headline" => "#{activity.trackable_type === 'Description'? my_model.title : my_model.name} action - #{activity.key}",
            "text" => my_model.description
          })
    end
    timeline_main.merge!("date" => activity_timeline)
    custom_timeline.merge!("timeline" => timeline_main)
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => custom_timeline.to_json }
    end
  end

  # GET /folders/1/edit
  def edit
    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  # POST /folders
  # POST /folders.json
  def create
    @trip = Trip.find_by_id(params[:trip_id])
    Rails.logger.debug ">>>> THe value of the folder params is #{folder_params} >> "
    @folder = @trip.folders.create(folder_params)
    @folder.create_activity key: 'Created Folder', owner: current_user

    respond_to do |format|
      if @folder.save
        format.html { redirect_to trip_folder_path(:trip_id => @trip.name,:id => @folder.name), notice: 'Folder was successfully created.' }
        format.json { render :show, status: :created, location: trip_folder_path(:trip_id => @trip.name,:id => folder.name) }
      else
        format.html { render :new }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /folders/1
  # PATCH/PUT /folders/1.json
  def update
    @folder.create_activity key: 'Updated Folder', owner: current_user
    respond_to do |format|
      if @folder.update(folder_params)
        format.html { redirect_to trip_folder_path(:trip_id => @trip.name,:id => @folder.name), notice: 'Folder was successfully updated.' }
        format.json { render :show, status: :ok, location: trip_folder_path(:trip_id => @trip.name,:id => @folder.name) }
      else
        format.html { render :edit }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /folders/1
  # DELETE /folders/1.json
  def destroy
    @folder.destroy
    respond_to do |format|
      format.html { redirect_to trip_path(:id => @trip.name), notice: 'Folder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder_name
      @trip = Trip.find_by_name(params[:trip_id])
      @folder = @trip.folders.find_by_name(params[:id])  
      @models_link = "description"
    end

    def set_folder_id
      @trip = Trip.find(params[:trip_id])
      @folder = @trip.folders.find(params[:id])  
      @models_link = "description"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def folder_params
      params.require(:folder).permit(:name, :mode, :trip_id, :total_cost, :description, :image)
    end
end
