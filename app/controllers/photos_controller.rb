class PhotosController < ApplicationController
  before_action :set_photo_id, only: [:update]
  before_action :set_photo_name, only: [ :show, :edit, :destroy]

  # GET /photos
  # GET /photos.json
  def index
    @trip = Trip.find_by_name(params[:trip_id])
    @folder = @trip.folders.find_by_name(params[:folder_id])
    @photos = @folder.photos.group_by{ |photo| photo.album }
    if request.headers['X-PJAX']
      render :layout => false
    else
      render :layout => "folder"
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @trip = Trip.find_by_name(params[:trip_id])
    @folder = @trip.folders.find_by_name(params[:folder_id])
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @trip = Trip.find_by_id(params[:trip_id])
    @folder = @trip.folders.find_by_id(params[:folder_id])
    @photo = @folder.photos.create(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to trip_folder_photos_path(:trip_id => @trip.name,:folder_id => @folder.name ), notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: trip_folder_photos_path(:trip_id => @trip.name,:folder_id => @folder.name ) }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to trip_folder_photos_path(:trip_id => @trip.name,:folder_id => @folder.name ), notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: trip_folder_photos_path(:trip_id => @trip.name,:folder_id => @folder.name ) }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_photo_name
      @trip = Trip.find_by_name(params[:trip_id])
      @folder = @trip.folders.find_by_name(params[:folder_id]) 
      @photo = @folder.photos.find_by_name(params[:id])
      @model_link = "photo"
    end

    def set_photo_id
      @trip = Trip.find_by_id(params[:trip_id])
      @folder = @trip.folders.find_by_id(params[:folder_id]) 
      @photo = @folder.photos.find_by_id(params[:id])
      @model_link = "photo"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:name, :album, :mode, :folder_id, :image)
    end
end
