class PlansController < ApplicationController
  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy]
  layout false
  before_action :set_plan_id, only: [:update]
  before_action :set_plan_name, only: [ :show, :edit, :destroy, :add_description]

  # GET /plans
  # GET /plans.json
  def index
    @trip = Trip.find_by_name(params[:trip_id])
    @folder = @trip.folders.find_by_name(params[:folder_id])
    @itenary = @folders.itenaries.find_by_name(params[:itenary_id])
    @plans = @itenary.plans
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
    if request.headers['X-PJAX']
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
      params.require(:plan).permit(:date_time, :name, :itenary_id, :short_description)
    end
end
