class DoctorsController < ApplicationController
  before_filter :check_admin, only: [:edit, :update, :destroy, :new, :create]
  before_action :set_doctor, only: [:show, :edit, :update, :destroy]
  before_action :set_most_recent, ony: [:new]
  helper_method :sort_column, :sort_direction


  def index
    @doctors = Doctor.order(sort_column + " " + sort_direction)
    respond_to do |format|
      format.html
      format.csv { render text: @doctors.to_csv }
    end
  end

  # GET /doctors/1
  # GET /doctors/1.json
  def show
  end

  # GET /doctors/new
  def new
    @doctor = Doctor.new
  end

  # GET /doctors/1/edit
  def edit
  end

  # POST /doctors
  # POST /doctors.json
  def create
    @doctor = Doctor.new(doctor_params)

    respond_to do |format|
      if @doctor.save
        format.html { redirect_to new_doctor_path, notice: 'Doctor (' + @doctor.name + ') was successfully created.' }
        format.json { render :show, status: :created, location: @doctor }
      else
        format.html { render :new }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /doctors/1
  # PATCH/PUT /doctors/1.json
  def update
    respond_to do |format|
      if @doctor.update(doctor_params)
        format.html { redirect_to @doctor, notice: 'Doctor (' + @doctor.name + ') was successfully updated.' }
        format.json { render :show, status: :ok, location: @doctor }
      else
        format.html { render :edit }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /doctors/1
  # DELETE /doctors/1.json
  def destroy
    @doctor.destroy
    respond_to do |format|
      format.html { redirect_to doctors_url, notice: 'Doctor (' + @doctor.name + ') was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doctor
      @doctor = Doctor.find(params[:id])
    end

  def set_most_recent
    @recent = Doctor.order("created_at").last
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def doctor_params
      params.require(:doctor).permit(:name, :address, :phone, :doctor_type)
    end
    def sort_column
      Doctor.column_names.include?(params[:sort]) ? params[:sort] : "name"
      Doctor.column_names.include?(params[:sort]) ? params[:sort] : "address"
      Doctor.column_names.include?(params[:sort]) ? params[:sort] : "phone"
      Doctor.column_names.include?(params[:sort]) ? params[:sort] : "doctor_type"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

  def check_admin
    redirect_to root_path, alert: "You do not have admin privileges." unless current_user.admin
  end

end
