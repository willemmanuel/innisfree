class ResidentsController < ApplicationController
  before_action :set_resident, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, only: [:new, :create, :destroy]
  before_action :check_house, only: [:edit, :update]

  # GET /residents/1
  # GET /residents/1.json
  def show
    @upcoming_appointments = Appointment.where('resident_id = ?', @resident.id)
  end

  # GET /residents/new
  def new
    @resident = Resident.new
  end

  # GET /residents/1/edit
  def edit
  end

  # POST /residents
  # POST /residents.json
  def create
    @resident = Resident.new(resident_params)
    respond_to do |format|
      if @resident.save
        format.html { redirect_to @resident, notice: 'Resident was successfully created.' }
        format.json { render :show, status: :created, location: @resident }
      else
        format.html { render :new }
        format.json { render json: @resident.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /residents/1
  # PATCH/PUT /residents/1.json
  def update
    respond_to do |format|
      if @resident.update(resident_params)
        format.html { redirect_to @resident, notice: 'Resident was successfully updated.' }
        format.json { render :show, status: :ok, location: @resident }
      else
        format.html { render :edit }
        format.json { render json: @resident.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /residents/1
  # DELETE /residents/1.json
  def destroy
    @resident.destroy
    respond_to do |format|
      format.html { redirect_to residents_url, notice: 'Resident was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Check to see if the user is an admin (staff)
    def check_admin
      redirect_to houses_path, alert: "You do not have admin privileges" unless current_user.admin
    end

    # Check to see if the user is in the same house as resident or an admin
    def check_house
      redirect_to houses_path, alert: "You are not in this resident's house and do not have admin privileges" unless current_user.admin or current_user.house_id == @resident.house_id
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_resident
      @resident = Resident.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resident_params
      params.require(:resident).permit(:name, :house_id, :notes)
    end
end