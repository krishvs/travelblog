class TripsController < ApplicationController

  #->Prelang (scaffolding:rails/scope_to_user)
  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy]

  before_action :set_trip, only: [:show, :edit, :update, :destroy, :collaborators, :add_collaborator]

  # GET /trips
  # GET /trips.json
  def index
    @trips = current_user.trips
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
  end

  # GET /trips/new
  def new
    @trip = Trip.new
  end

  # GET /trips/1/edit
  def edit
  end

  def collaborators
  end

  def add_collaborator
    if request.xhr?
      user = User.find_by_username(params[:user])
      if user
        if user.id != current_user.id
          @trip.users += [user]
        end
        Rails.logger.info ">>>>> Got a user #{user.inspect}"
        render :json => { :action => "user_added" }
      else
        Rails.logger.info ">>>>> No user #{params[:user]}"
        render :json => { :action => "user_added" }
      end
    end
  end

  # POST /trips
  # POST /trips.json
  def create
    @trip = Trip.new(trip_params)
    users = [current_user]
    @trip.users += users

    respond_to do |format|
      if @trip.save
        format.html { redirect_to trips_path, notice: 'Trip was successfully created.' }
        format.json { render :show, status: :created, location: trips_path }
      else
        format.html { render :new }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update
    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to trips_path, notice: 'Trip was successfully updated.' }
        format.json { render :show, status: :ok, location: trips_path }
      else
        format.html { render :edit }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to trips_url, notice: 'Trip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find_by_name(params[:id])
      Rails.logger.debug ">>>>> The value of the trip is #{@trip.folders.inspect} >>>> "
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_params
      params.require(:trip).permit(:name, :user_id, :mode, :description)
    end
end
