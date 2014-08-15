class MapsController < ApplicationController
  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy]

  before_action :set_map_id, only: [:update]
  before_action :set_map_name, only: [ :show, :edit, :destroy]
  before_action :set_domain, only: [:public_show]

  # GET /maps
  # GET /maps.json
  def index
    @trip = Trip.find_by_name(params[:trip_id])
    @folder = @trip.folders.find_by_name(params[:folder_id])
    @maps = @folder.maps
    if request.headers['X-PJAX']
      render :layout => false
    else
      render :layout => "folder"
    end
  end

  # GET /maps/1
  # GET /maps/1.json
  def show
    @addresses = @map.addresses
    if request.headers['X-PJAX']
      render :layout => false
    else
      render :layout => "folder"
    end
  end

  def public_show
    @addresses = @map.addresses      
    render :layout => "iframe"
  end

  # GET /maps/new
  def new
    @trip = Trip.find_by_name(params[:trip_id])
    @folder = @trip.folders.find_by_name(params[:folder_id])
    @map = Map.new
    if request.headers['X-PJAX']
      render :layout => false
    else
      render :layout => "folder"
    end
  end

  # GET /maps/1/edit
  def edit
  end

  # POST /maps
  # POST /maps.json
  def create
    @trip = Trip.find_by_id(params[:trip_id])
    @folder = @trip.folders.find_by_id(params[:folder_id])
    @map = @folder.maps.create(map_params)
    if map_params[:mode]
      @map.create_activity key: 'Created Map', owner: @folder
    end
    respond_to do |format|
      if @map.save
        format.html { redirect_to trip_folder_map_path(:trip_id => @trip.name,:folder_id => @folder.name,:id => @map.name ), notice: 'Map was successfully created.' }
        format.json { render :show, status: :created, location: trip_folder_map_path(:trip_id => @trip.name,:folder_id => @folder.name,:id => @map.name ) }
      else
        format.html { render :new }
        format.json { render json: @map.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maps/1
  # PATCH/PUT /maps/1.json
  def update
    if map_params[:mode]
      @map.create_activity key: 'Updated Map', owner: @folder
    end
    respond_to do |format|
      if @map.update(map_params)
        format.html { redirect_to trip_folder_map_path(:trip_id => @trip.name,:folder_id => @folder.name,:id => @map.name ), notice: 'Map was successfully updated.' }
        format.json { render :show, status: :ok, location: trip_folder_map_path(:trip_id => @trip.name,:folder_id => @folder.name,:id => @map.name ) }
      else
        format.html { render :edit }
        format.json { render json: @map.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maps/1
  # DELETE /maps/1.json
  def destroy
    @map.destroy
    respond_to do |format|
      format.html { redirect_to trip_folder_maps_path(:trip_id => @trip.name,:folder_id => @folder.name ), notice: 'Map was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_domain
      response.headers.except! 'X-Frame-Options'
      Rails.logger.info "I am in the set_blog"
      @user = User.find_by_domain(request.host)
      @map = Map.find_by_url(params[:name])
      Rails.logger.info "The value of the user is #{@user.inspect}"
      unless @user
        redirect_to root_path
      end
    end
    
    def set_map_name
      @trip = Trip.find_by_name(params[:trip_id])
      @folder = @trip.folders.find_by_name(params[:folder_id]) 
      @map = @folder.maps.find_by_name(params[:id])
      @model_link = "map"
    end

    def set_map_id
      @trip = Trip.find_by_id(params[:trip_id])
      @folder = @trip.folders.find_by_id(params[:folder_id]) 
      @map = @folder.maps.find_by_id(params[:id])
      @model_link = "map"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def map_params
      params.require(:map).permit(:name, :mode, :description, :transport)
    end
end
