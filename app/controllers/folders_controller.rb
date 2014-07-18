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
  end

  # GET /folders/new
  def new
    Rails.logger.debug ">>> The value of the params is #{params.inspect} "
    @trip = Trip.find_by_name(params[:trip_id])
    @folder = Folder.new
  end

  # GET /folders/1/edit
  def edit
  end

  # POST /folders
  # POST /folders.json
  def create
    @trip = Trip.find_by_name(params[:trip_id])
    Rails.logger.debug ">>>> THe value of the folder params is #{folder_params} >> "
    @folder = @trip.folders.create(folder_params)

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
    end

    def set_folder_id
      @trip = Trip.find(params[:trip_id])
      @folder = @trip.folders.find(params[:id])  
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def folder_params
      params.require(:folder).permit(:name, :mode, :trip_id, :total_cost, :description, :image)
    end
end
