# Doctors Controller controls all the manipulation of doctors, it allows you to view, create, edit and delete doctors. 

class DoctorsController < ApplicationController
  before_filter :check_admin, only: [:edit, :update, :destroy, :new, :create]
  before_action :set_doctor, only: [:show, :edit, :update, :destroy]
  before_action :set_most_recent, ony: [:new]
  helper_method :sort_column, :sort_direction


  # GET /doctors
  # GET /doctors.json
  # Index page displays the list of all doctors and their corresponding information

  def index
    @doctors = Doctor.order(sort_column + " " + sort_direction) # allows the sorting of doctors by name, address, phone, or doctor type
    respond_to do |format|
      format.html # returns the html of that page
      format.csv { render text: @doctors.to_csv } # allows doctors to be downloaded as a CSV file
    end
  end

  # GET /doctors/1
  # GET /doctors/1.json
  # shows the information with regard to specific doctor

  def show
  end

  # GET /doctors/new
  # populate each field for the creation of a new doctor

  def new
    @doctor = Doctor.new #create a new doctor
  end

  # GET /doctors/1/edit
  # allows you to edit each doctor's information
  def edit
  end

  # POST /doctors
  # POST /doctors.json
  # allows you to create a new doctor after you fill out fields for new doctors
  # 

  def create
    @doctor = Doctor.new(doctor_params) # use fields of 

    respond_to do |format|
      if @doctor.save # if there are no errors in the doctor data
        format.html { redirect_to new_doctor_path, notice: 'Doctor (' + @doctor.name + ') was successfully created.' } # redirect browser to that specific doctor's page and show "sucessful" message
        format.json { render :show, status: :created, location: @doctor }
      else # if there are errors when creading the doctor
        format.html { render :new }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /doctors/1
  # PATCH/PUT /doctors/1.json
  # update the information with regard to each doctor

  def update
    respond_to do |format|
      if @doctor.update(doctor_params)
        format.html { redirect_to @doctor, notice: 'Doctor (' + @doctor.name + ') was successfully updated.' } # redirect browser to that doctor's page and show "successful" message
        format.json { render :show, status: :ok, location: @doctor }
      else # if there are errors when editing the doctors, tell the user where is wrong
        format.html { render :edit }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /doctors/1
  # DELETE /doctors/1.json
  # delete the doctor and redirect user to main doctor page after each deletion

  def destroy
    @doctor.destroy
    respond_to do |format|
      format.html { redirect_to doctors_url, notice: 'Doctor (' + @doctor.name + ') was successfully deleted.' } # redirect browser to main doctor page and show "successful" message
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doctor
      @doctor = Doctor.find(params[:id])
    end

    # order the doctors by the most recent creation time
    def set_most_recent
      @recent = Doctor.order("created_at").last
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def doctor_params
      params.require(:doctor).permit(:name, :address, :phone, :doctor_type)
    end
    
    # helps to sort the doctors by each field, each field that will be sorted should appear here
    def sort_column
      Doctor.column_names.include?(params[:sort]) ? params[:sort] : "name"
      Doctor.column_names.include?(params[:sort]) ? params[:sort] : "address"
      Doctor.column_names.include?(params[:sort]) ? params[:sort] : "phone"
      Doctor.column_names.include?(params[:sort]) ? params[:sort] : "doctor_type"
    end

    # defines the direction of sorting
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

  # check if the user had admin privileges to the system
  def check_admin
    redirect_to root_path, alert: "You do not have admin privileges." unless current_user.admin
  end

end
