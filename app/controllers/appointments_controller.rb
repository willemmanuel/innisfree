class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  # GET /appointments
  # GET /appointments.json
  def index
    if not @appointments.nil?
    appointment_count = @appointments.count
    logger.debug "in the update_appointments method with a non-nil @appointments. Appointments has length " + appointment_count.to_s

    end

    logger.debug "in the index method"
    @residents = Resident.all
    @houses = House.all
    if @appointments.nil?
    @appointments = Appointment.all
    end
    appointment_count = @appointments.count
    logger.debug "in the update_appointments method. Appointments has length " + appointment_count.to_s
    @past_appointments = Appointment.where('date < ?', Date.today)
    @upcoming_appointments = Appointment.where('date >= ?', Date.today)
<<<<<<< HEAD
    # @upcoming_appointments = Appointment.where('date > ?', Date.today).paginate(page: params[:upcoming_page], per_page: 10)
    respond_to do |format|
      format.html
      format.json
      format.csv { render text:@appointments.to_csv }
    end
=======
>>>>>>> a8907a4... Want to be able to find this again....
  end

  # GET /appointments
  # GET /appointments.json
  def update_residents
    @residents = Resident.where("house_id = ?", params[:house_id])
    #residents_count = Resident.where("house_id = ?", params[:house_id]).count
    #logger.debug "in the update_residents method. Residents has length " + residents_count.to_s
    respond_to do |format|
   	format.html
	format.js
    end
  end

  # GET /appointments
  # GET /appointments.json
  def update_appointments
    @appointments = Appointment.where("resident_id = ?", params[:resident_id])
    appointment_count = Appointment.where("resident_id = ?", params[:resident_id]).count
    logger.debug "in the update_appointments method. Appointments has length " + appointment_count.to_s
    respond_to do |format|
        logger.debug 'responding to format'
   	format.html
	format.js
        format.json { render :update_appointments, status: :ok }
    end
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: 'Appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:resident_id, :physician_id, :volunteer_id, :date, :time, :for, :notes)
    end
end
