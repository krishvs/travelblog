class PlansController < ApplicationController
  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy]
  layout false
  before_action :set_plan_id, only: [:update]
  before_action :set_plan_name, only: [ :show, :edit, :destroy, :add_description, :add_discussion, :discussions, :add_map, :maps]

  # GET /plans
  # GET /plans.json
  def index
    @trip = Trip.find_by_name(params[:trip_id])
    @folder = @trip.folders.find_by_name(params[:folder_id])
    @itenary = @folder.itenaries.find_by_name(params[:itenary_id])
    @plans = @itenary.plans
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
    if request.headers['X-PJAX']
      render :layout => false
    elsif request.xhr?
      render :layout => false
    else
      render :layout => "folder"
    end
  end

  def add_description
    if request.xhr?
      description = @folder.descriptions.find_by_title(params[:description])
      if description
        descriptions = @plan.descriptions ? @plan.descriptions : []
        descriptions.push(description.id)
        if @plan.update_attributes({:descriptions => descriptions})  
          Rails.logger.info ">>>>> Got a plan #{@plan.inspect}"
          render :json => { :action => "description_added" }
        else  
           render :json => { :action => "description_not_added" }
        end
      else
        Rails.logger.info ">>>>> No description #{params[:description]}"
        render :json => { :action => "descripiton_not_found" }
      end
    end
  end

  def add_discussion
    if request.xhr?
      discussion = @folder.discussions.create({:name => params[:name]})
      if discussion.save
        descriptions = @plan.descriptions ? @plan.descriptions : {:discussions => [], :maps => [] }
        descriptions["discussions"].push(discussion.id)
        if @plan.update_attributes({:descriptions => descriptions})  
          Rails.logger.info ">>>>> Got a plan #{@plan.inspect}"
          render :json => { :action => "discussion_added" }
        else  
           render :json => { :action => "discussion_not_added" }
        end
      else
        render :json => { :action => "discussion_not_added" }
      end 
    end
  end

  def add_map
    if request.xhr?
      map = @folder.maps.create({:name => params[:name], :description => params[:description], :transport => params[:transport]})
      if map.save
        descriptions = @plan.descriptions ? @plan.descriptions : {:discussions => [], :maps => [] }
        Rails.logger.debug ">>> Value of descriptions is #{descriptions.inspect}  #{descriptions[:maps]} #{map.id}"
        descriptions[:maps] << map.id
        Rails.logger.info ">>> The value of "
        if @plan.update_attributes({:descriptions => descriptions})  
          Rails.logger.info ">>>>> Got a plan #{@plan.inspect}"
          render :json => { :action => "map_added" }
        else  
           render :json => { :action => "map_not_added" }
        end
      else
        render :json => { :action => "map_not_added" }
      end 
    end
  end

  def maps
    mapIds = @plan.descriptions ? @plan.descriptions["maps"] : nil
    if mapIds
      @maps = [];
      @maps = @folder.maps.find_by_id(mapIds)
      unless @maps.kind_of?(Array)
        @maps = [@maps]
      end
    else
      @maps = []
    end
    if request.headers['X-PJAX']
      render :layout => false
    else
      render :layout => "folder"
    end
  end

  def discussions
    discussionIds = @plan.descriptions ? @plan.descriptions["discussions"] : nil
    if discussionIds
      @discussions = [];
      @discussions = @folder.discussions.find_by_id(discussionIds)
      unless @discussions.kind_of?(Array)
        @discussions = [@discussions]
      end
    else
      @discussions = []
    end
    if request.headers['X-PJAX']
      render :layout => false
    else
      render :layout => "folder"
    end
  end

  # GET /plans/new
  def new
    @trip = Trip.find_by_name(params[:trip_id])
    @folder = @trip.folders.find_by_name(params[:folder_id])
    @itenary = @folder.itenaries.find_by_name(params[:itenary_id])
    @plan = Plan.new
  end

  # GET /plans/1/edit
  def edit
  end

  # POST /plans
  # POST /plans.json
  def create
    @trip = Trip.find_by_id(params[:trip_id])
    @folder = @trip.folders.find_by_id(params[:folder_id])
    @itenary = @folder.itenaries.find_by_id(params[:itenary_id])
    @plan = @itenary.plans.create(plan_params)

    respond_to do |format|
      if @plan.save
        format.html { redirect_to trip_folder_itenary_path(:trip_id => @trip.name,:folder_id => @folder.name, :id => @itenary.name), notice: 'Plan was successfully created.' }
        format.json { render :show, status: :created, location: trip_folder_itenary_path(:trip_id => @trip.name,:folder_id => @folder.name, :id => @itenary.name) }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to @plan, notice: 'Plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to plans_url, notice: 'Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
     def set_plan_name
      @trip = Trip.find_by_name(params[:trip_id])
      @folder = @trip.folders.find_by_name(params[:folder_id]) 
      @itenary = @folder.itenaries.find_by_name(params[:itenary_id])
      @plan = @itenary.plans.find_by_name(params[:id])
    end

    def set_plan_id
      @trip = Trip.find_by_id(params[:trip_id])
      @folder = @trip.folders.find_by_id(params[:folder_id]) 
      @itenary = @folder.itenaries.find_by_id(params[:itenary_id])
      @plan = @itenary.plans.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:date_time, :name, :itenary_id, :short_description, :price_cent)
    end
end
