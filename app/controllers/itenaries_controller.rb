class ItenariesController < ApplicationController

  before_action :set_itenary_id, only: [:update]
  before_action :set_itenary_name, only: [ :show, :edit, :destroy]

  # GET /itenaries
  # GET /itenaries.json
  def index
    @trip = Trip.find_by_name(params[:trip_id])
    @folder = @trip.folders.find_by_name(params[:folder_id])
    @itenaries = @folder.itenaries
    if request.headers['X-PJAX']
      render :layout => false
    else
      render :layout => "folder"
    end
  end

  # GET /itenaries/1
  # GET /itenaries/1.json
  def show
    if request.headers['X-PJAX']
      render :layout => false
    elsif request.xhr?
      render "plan_index", :layout => false
    else
      render :layout => "folder"
    end
  end

  # GET /itenaries/new
  def new
    @trip = Trip.find_by_name(params[:trip_id])
    @folder = @trip.folders.find_by_name(params[:folder_id])
    @itenary = Itenary.new
    if request.headers['X-PJAX']
      render :layout => false
    else
      render :layout => "folder"
    end
  end

  # GET /itenaries/1/edit
  def edit
  end

  # POST /itenaries
  # POST /itenaries.json
  def create
    @trip = Trip.find_by_id(params[:trip_id])
    @folder = @trip.folders.find_by_id(params[:folder_id])
    @itenary = @folder.itenaries.create(itenary_params)

    respond_to do |format|
      if @itenary.save
        format.html { redirect_to trip_folder_itenaries_path(:trip_id => @trip.name, :folder_id => @folder.name), notice: 'Itenary was successfully created.' }
        format.json { render :show, status: :created, location: trip_folder_itenaries_path(:trip_id => @trip.name, :folder_id => @folder.name) }
      else
        format.html { render :new }
        format.json { render json: @itenary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /itenaries/1
  # PATCH/PUT /itenaries/1.json
  def update
    respond_to do |format|
      if @itenary.update(itenary_params)
        format.html { redirect_to @itenary, notice: 'Itenary was successfully updated.' }
        format.json { render :show, status: :ok, location: @itenary }
      else
        format.html { render :edit }
        format.json { render json: @itenary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /itenaries/1
  # DELETE /itenaries/1.json
  def destroy
    @itenary.destroy
    respond_to do |format|
      format.html { redirect_to itenaries_url, notice: 'Itenary was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_itenary_name
      @trip = Trip.find_by_name(params[:trip_id])
      @folder = @trip.folders.find_by_name(params[:folder_id]) 
      @itenary = @folder.itenaries.find_by_name(params[:id])
      @model_link = "itenary"
    end

    def set_itenary_id
      @trip = Trip.find_by_id(params[:trip_id])
      @folder = @trip.folders.find_by_id(params[:folder_id]) 
      @itenary = @folder.itenaries.find_by_id(params[:id])
      @model_link = "itenary"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def itenary_params
      params.require(:itenary).permit(:name, :mode, :short_description)
    end
end
