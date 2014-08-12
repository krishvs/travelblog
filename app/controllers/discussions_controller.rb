class DiscussionsController < ApplicationController

  before_action :set_discussion_id, only: [:update]
  before_action :set_discussion_name, only: [ :show, :edit, :destroy, :add_comment]

  # GET /discussions
  # GET /discussions.json
  def index
    @trip = Trip.find_by_name(params[:trip_id])
    @folder = @trip.folders.find_by_name(params[:folder_id])
    @discussions = @folder.discussions
    if request.headers['X-PJAX']
      render :layout => false
    else
      render :layout => "folder"
    end
  end

  # GET /discussions/1
  # GET /discussions/1.json
  def show
    if request.headers['X-PJAX']
      render :layout => false
    else
      render :layout => "folder"
    end
  end

  # GET /discussions/new
  def new
    @trip = Trip.find_by_name(params[:trip_id])
    @folder = @trip.folders.find_by_name(params[:folder_id])
    @discussion = Discussion.new
    if request.headers['X-PJAX']
      render :layout => false
    else
      render :layout => "folder"
    end
  end

  # GET /discussions/1/edit
  def edit
  end

  def add_comment
    @comment = Comment.build_from(@discussion,current_user.id,params[:comment])
    if @comment.save
      render :json => { :action => "comment_added" }
    end
  end

  # POST /discussions
  # POST /discussions.json
  def create
    @trip = Trip.find_by_id(params[:trip_id])
    @folder = @trip.folders.find_by_id(params[:folder_id])
    @discussion = @folder.discussions.create(discussion_params)
    respond_to do |format|
      if @discussion.save
        format.html { redirect_to trip_folder_discussions_path(:trip_id => @trip.name, :folder_id => @folder.name ), notice: 'Discussion was successfully created.' }
        format.json { render :show, status: :created, location: trip_folder_discussions_path(:trip_id => @trip.name, :folder_id => @folder.name ) }
      else
        format.html { render :new }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /discussions/1
  # PATCH/PUT /discussions/1.json
  def update
    respond_to do |format|
      if @discussion.update(discussion_params)
        format.html { redirect_to @discussion, notice: 'Discussion was successfully updated.' }
        format.json { render :show, status: :ok, location: @discussion }
      else
        format.html { render :edit }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discussions/1
  # DELETE /discussions/1.json
  def destroy
    @discussion.destroy
    respond_to do |format|
      format.html { redirect_to discussions_url, notice: 'Discussion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_discussion_name
      @trip = Trip.find_by_name(params[:trip_id])
      @folder = @trip.folders.find_by_name(params[:folder_id]) 
      @discussion = @folder.discussions.find_by_name(params[:id])
      @model_link = "discussion"
    end

    def set_discussion_id
      @trip = Trip.find_by_id(params[:trip_id])
      @folder = @trip.folders.find_by_id(params[:folder_id]) 
      @discussion = @folder.discussions.find_by_id(params[:id])
      @model_link = "discussion"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def discussion_params
      params.require(:discussion).permit(:name, :description)
    end
end
