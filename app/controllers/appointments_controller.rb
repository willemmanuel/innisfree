class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  # GET /appointments
  # GET /appointments.json
  def index
    @residents = Resident.all
    @houses = House.all
    if params.has_key?(:res_id)
      session[:res_id] = params[:res_id]
    end
    if params.has_key?(:house_id)
      session[:house_id] = params[:house_id]
    end
    if session.has_key?(:res_id) and session[:res_id] != '' 
      logger.debug "res id"
      @appointments = Appointment.where('resident_id = ?', session[:res_id])
      @past_appointments = Appointment.where('date < ?', Date.today)
      @upcoming_appointments = Appointment.where('date >= ?', Date.today).paginate(:per_page => 10, :page => params[:page])
      respond_to do |format|
        format.html
        format.json
        format.js
        format.csv { render text:@appointments.to_csv }
      end
    elsif session.has_key?(:house_id) and session[:house_id] != '' 
      logger.debug "house id"
      @appointments = Appointment.joins('LEFT OUTER JOIN residents ON resident_id = residents.id').where('house_id = ?', session[:house_id])
      logger.debug @appointments.count.to_s
      @past_appointments = Appointment.where('date < ?', Date.today)
      @upcoming_appointments = Appointment.where('date >= ?', Date.today).paginate(:per_page => 10, :page => params[:page])
      respond_to do |format|
        format.html
        format.json
        format.js
        format.csv { render text:@appointments.to_csv }
      end
    else 
      @appointments = Appointment.all
      logger.debug "no params"
      @past_appointments = Appointment.where('date < ?', Date.today)
      @upcoming_appointments = Appointment.where('date >= ?', Date.today).paginate(:per_page => 10, :page => params[:page])
      respond_to do |format|
        format.html
        format.json
        format.js
        format.csv { render text:@appointments.to_csv }
      end
    end
  end

  # GET /appointments
  # GET /appointments.json
  def update_residents
    if (params[:house_id] != '')
      @residents = Resident.where("house_id = ?", params[:house_id])
    else
      @residents = Resident.all
    end
    respond_to do |format|
   	format.html
	format.js
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

  def appointments
    @appointments
  end

  def residents
    @residents
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:resident_id, :doctor_id, :user_id, :date, :time, :for, :notes, :res_id, :house_id)
    end
end
