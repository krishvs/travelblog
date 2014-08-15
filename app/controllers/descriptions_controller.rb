class DescriptionsController < ApplicationController
  before_action :set_description_id, only: [:update]
  layout "blog_article", only: [:new, :edit]
  layout "blog", only: [:show]
  before_action :set_description_name, only: [ :show, :edit, :destroy, :template]

  # GET /descriptions
  # GET /descriptions.json
  def index
    @trip = Trip.find_by_name(params[:trip_id])
    @folder = @trip.folders.find_by_name(params[:folder_id])
    @descriptions = @folder.descriptions
    if request.headers['X-PJAX']
      render :layout => false
    else
      render :layout => "folder"
    end
  end

  # GET /descriptions/1
  # GET /descriptions/1.json
  def show
    if request.headers['X-PJAX']
      render :layout => false
    else
      render :layout => "folder"
    end
  end

  def template
    @template = current_user.template.template 
     if request.headers['X-PJAX']
      render :layout => false
    else
      render :layout => "folder"
    end
  end

  def update_template
    @trip = Trip.find_by_name(params[:trip_id])
    @folder = @trip.folders.find_by_name(params[:folder_id])
    current_user.template.template = params[:template]
    if current_user.template.save
        redirect_to trip_folder_descriptions_path
      else
        format.html { render :new }
        format.json { render json: @description.errors, status: :unprocessable_entity }
      end
  end

  # GET /descriptions/new
  def new
    @trip = Trip.find_by_name(params[:trip_id])
    @folder = @trip.folders.find_by_name(params[:folder_id])
    @description = Description.new
    if request.headers['X-PJAX']
      render :layout => false
    else
      render :layout => "blog_article"
    end
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
    @description.user = current_user
    Rails.logger.debug ">>> The valuej of the params is #{description_params[:mode]}  node is #{description_params.inspect}"
    if description_params[:mode]  
      Rails.logger.debug ">>>> I am creating a description here >>>>>>>>> in the public acticity "
      @description.create_activity key: 'Created Description', owner: @folder
    end

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
    if description_params[:mode]
      @description.create_activity key: 'Updated Description', owner: @folder
    end
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
      @model_link = "description"
    end

    def set_description_id
      @trip = Trip.find_by_id(params[:trip_id])
      @folder = @trip.folders.find_by_id(params[:folder_id]) 
      @description = @folder.descriptions.find_by_id(params[:id])
      @model_link = "description"
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def description_params
      params.require(:description).permit(:folder_id, :description, :title, :mode)
    end
end
