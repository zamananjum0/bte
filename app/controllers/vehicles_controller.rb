class VehiclesController < ApplicationController
  load_and_authorize_resource
  before_action :set_vehicle, only: [:show, :edit, :update, :destroy]
  
  def index
    @vehicles
  end
  
  def new
    authorize :vehicle
    @vehicle = Vehicle.new
  end
  
  def edit
    authorize :vehicle
  end
  
  def create
    @vehicle         = Vehicle.new(vehicle_params)
    @vehicle.site_id = current_user.site_id
    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to vehicles_path }
        format.json { render :show, status: :created, location: @vehicle }
      else
        format.html { render :new }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @vehicle.update(vehicle_params)
        format.html { redirect_to vehicles_path }
        format.json { render :show, status: :ok, location: @vehicle }
      else
        format.html { render :edit }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    authorize :vehicle
    if @vehicle.is_deleted
      @vehicle.is_deleted = false
      notice              = 'Vehicle was successfully undo.'
    else
      @vehicle.is_deleted = true
      notice              = 'Vehicle was successfully destroyed.'
    end
    @vehicle.save!
    respond_to do |format|
      format.html { redirect_to vehicles_url, notice: notice }
      format.json { head :no_content }
    end
  end
  
  def get_users
    user_vehicle = UserVehicle.where(end_date: nil, vehicle_id: params[:vehicle_id], is_deleted: false)
    role_id      = Role.find_by_name(AppConstants::DRIVER).id
    @users       = User.where(role_id: role_id, is_deleted: false)
    
    if user_vehicle.present?
      return render json: { status: false, users: @users }
    else
      return render json: { status: true, users: @users }
    end
    # return render json: false
  end
  
  private
  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end
  
  def vehicle_params
    params.require(:vehicle).permit(:vehicle_type, :vehicle_number)
  end
end
