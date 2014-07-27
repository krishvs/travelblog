class DescriptionsController < ApplicationController
  before_action :set_description_id, only: [:update]
  layout "description", only: [:new, :edit]
  before_action :set_description_name, only: [ :show, :edit, :destroy]

  # GET /descriptions
  # GET /descriptions.json
  def index
    @trip = Trip.find_by_name(params[:trip_id])
    @folder = @trip.folders.find_by_name(params[:folder_id])
    @descriptions = @folder.descriptions
  end

  # GET /descriptions/1
  # GET /descriptions/1.json
  def show
  end

  # GET /descriptions/new
  def new
    @trip = Trip.find_by_name(params[:trip_id])
    @folder = @trip.folders.find_by_name(params[:folder_id])
    @description = Description.new
  end

  # GET /descriptions/1/edit
  def edit
  end

  # POST /descriptions
  # POST /descriptions.json
  def create
    @trip = Trip.find_by_id(params[:trip_id])
    @folder = @trip.folders.find_by_id(params[:folder_id])
    @description = @folder.descriptions.create(description_params)

    respond_to do |format|
      if @description.save
        format.html { redirect_to trip_folder_descriptions_path(:trip_id => @trip.name,:folder_id => @folder.name ), notice: 'Description was successfully created.' }
        format.json { render :show, status: :created, location: trip_folder_descriptions_path(:trip_id => @trip.name,:folder_id => @folder.name ) }
      else
        format.html { render :new }
        format.json { render json: @description.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /descriptions/1
  # PATCH/PUT /descriptions/1.json
  def update
    respond_to do |format|
      if @description.update(description_params)
        format.html { redirect_to trip_folder_descriptions_path(:trip_id => @trip.name,:folder_id => @folder.name ), notice: 'Description was successfully updated.' }
        format.json { render :show, status: :ok, location: @description }
      else
        format.html { render :edit }
        format.json { render json: @description.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /descriptions/1
  # DELETE /descriptions/1.json
  def destroy
    @description.destroy
    respond_to do |format|
      format.html { redirect_to descriptions_url, notice: 'Description was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_description_name
      @trip = Trip.find_by_name(params[:trip_id])
      @folder = @trip.folders.find_by_name(params[:folder_id]) 
      @description = @folder.descriptions.find_by_title(params[:id])
    end

    def set_description_id
      @trip = Trip.find_by_id(params[:trip_id])
      @folder = @trip.folders.find_by_id(params[:folder_id]) 
      @description = @folder.descriptions.find_by_id(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def description_params
      params.require(:description).permit(:folder_id, :description, :title, :mode)
    end
end
