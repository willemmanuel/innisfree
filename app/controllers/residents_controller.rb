# The resident controller manages resident data, and serves as the controller to both access and modify data regarding residents. It also verifies privileges for each call when appropriate.

class ResidentsController < ApplicationController
  before_action :set_resident, only: [:show, :edit, :update, :destroy] # loads the specified resident before showing, editing, or deleting
  before_action :check_admin, only: [:new, :create, :index, :destroy] # makes sure that the user is an admin before creating, destroying, or viewing the management page
  before_action :check_house, only: [:edit, :update] # makes sure that the user is in the resident's house or an admin before editing
  before_action :set_most_recent, only: [:new] # loads the most recently created resident if creating
  helper_method :sort_column # helper method for sorting

  # GET /residents
  # GET /residents.json
  # index - the main page for resident management for admins, lists all the resident and shows links for details, edit, and delete
  def index
    @residents = Resident.all
    respond_to do |format|
      format.html
      format.csv { render text: @residents.to_csv }
    end
  end

  # GET /residents/1
  # GET /residents/1.json
  # show - shows the resident and upcoming appointments for resident
  def show
    @upcoming_appointments = Appointment.where('resident_id = ?', @resident.id)
  end

  # GET /residents/new
  # new - creates a new resident object
  def new
    @resident = Resident.new
  end

  # GET /residents/1/edit
  # edit - opens a resident for changes
  def edit
  end

  # POST /residents
  # POST /residents.json
  # create - saves the new resident to database, and shows resident page, or an error if unsuccessful
  def create
    @resident = Resident.new(resident_params)
    respond_to do |format|
      if @resident.save
        format.html { redirect_to new_resident_path, notice: 'Resident (' + @resident.name + ') was successfully created.' }
        format.json { render :show, status: :created, location: @resident }
      else
        format.html { render :new }
        format.json { render json: @resident.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /residents/1
  # PATCH/PUT /residents/1.json
  # update - saves the edited resident data to database, and shows resident page, or an error if unsuccessful
  def update
    respond_to do |format|
      if @resident.update(resident_params)
        format.html { redirect_to @resident, notice: 'Resident (' + @resident.name + ') was successfully updated.' }
        format.json { render :show, status: :ok, location: @resident }
      else
        format.html { render :edit }
        format.json { render json: @resident.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /residents/1
  # DELETE /residents/1.json
  # destroy - removes the resident from database, and shows a success message
  def destroy
    @resident.destroy
    respond_to do |format|
      format.html { redirect_to residents_url, notice: 'Resident (' + @resident.name + ') was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
  # check_admin - checks to see if the user is an admin (staff)
  def check_admin
    redirect_to houses_path, alert: "You do not have admin privileges." unless current_user.admin
  end

  # check_house - checks to see if the user is in the same house as resident or an admin
  def check_house
    redirect_to houses_path, alert: "You do not have access to this house." unless current_user.admin or current_user.house_id == @resident.house_id
  end

  # set_resident - finds the resident with the specified id parameter
  # Use callbacks to share common setup or constraints between actions.
  def set_resident
    @resident = Resident.find(params[:id])
  end

  # set_most_recent - sets the most recently created resident
  def set_most_recent
    @recent = Resident.order("created_at").last
  end

  # resident_params - defines what specific parameters are allowed for a resident
  # Never trust parameters from the scary internet, only allow the white list through.
  def resident_params
    params.require(:resident).permit(:name, :house_id, :notes)
  end
end

# sort_column - defines how the columns for upcoming appointments are sorted
def sort_column
  Appointment.column_names.include?(params[:sort]) ? params[:sort] : "resident_id"
  Appointment.column_names.include?(params[:sort]) ? params[:sort] : "doctor_id"
  Appointment.column_names.include?(params[:sort]) ? params[:sort] : "user_id"
  Appointment.column_names.include?(params[:sort]) ? params[:sort] : "date"
  Appointment.column_names.include?(params[:sort]) ? params[:sort] : "time"
  Appointment.column_names.include?(params[:sort]) ? params[:sort] : "apt_type"
end