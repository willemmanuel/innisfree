class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy, :send_house_reminder]
  before_action :check_workstation_head, only: [:new, :edit, :create, :update, :destroy]
  before_action :check_admin, only: [:destroy, :send_house_reminder]
  before_action :check_house, only: [:edit, :update]
  helper_method :sort_column, :sort_direction

  # GET /appointments
  # GET /appointments.json
  def index
    @residents = Resident.all
    @houses = House.all
    @past_appointments = Appointment.where('date < ?', Date.today)
    @upcoming_appointments = Appointment.where('date >= ?', Date.today).paginate( :page => params[:page], :per_page => 10).order(sort_column + " " + sort_direction)
    if params.has_key?(:res_id)
      session[:res_id] = params[:res_id]
    end
    if params.has_key?(:house_id)
      session[:house_id] = params[:house_id]
    end
    if session.has_key?(:res_id) and session[:res_id] != ''
      @appointments = Appointment.where('resident_id = ?', session[:res_id])
      @appointments_counts = @appointments.group("date").count
    elsif session.has_key?(:house_id) and session[:house_id] != ''
      @appointments = Appointment.joins('LEFT OUTER JOIN residents ON resident_id = residents.id').where('house_id = ?', session[:house_id])
      @appointments_counts = @appointments.group("date").count
    else
      @appointments = Appointment.all
      @appointments_counts = @appointments.group('date').count
    end
    respond_to do |format|
      format.html
      format.json
      format.js
      format.csv { render text:@appointments.to_csv }
    end
  end

  def upcoming
    if params.has_key?(:res_id)
      session[:res_id] = params[:res_id]
    end
    if params.has_key?(:house_id)
      session[:house_id] = params[:house_id]
    end
    if session.has_key?(:res_id) and session[:res_id] != ''
      @upcoming_appointments = Appointment.where('resident_id = ?', session[:res_id]).where('date >= ?', Date.today).paginate(:per_page => 10, :page => params[:page])
    elsif session.has_key?(:house_id) and session[:house_id] != ''
      @upcoming_appointments = Appointment.joins('LEFT OUTER JOIN residents ON resident_id = residents.id').where('house_id = ?', session[:house_id]).where('date >= ?', Date.today).paginate(:per_page => 10, :page => params[:page])
    else
      @upcoming_appointments = Appointment.where('date >= ?', Date.today).paginate(:per_page => 10, :page => params[:page])
    end
    @paginate = true
    render "appointments/_upcoming", :layout => false
  end

  def appointments_for_day
    if params.has_key?(:date)
      session[:date] = params[:date]
    end
    if params.has_key?(:res_id)
      session[:res_id] = params[:res_id]
    end
    if params.has_key?(:house_id)
      session[:house_id] = params[:house_id]
    end
    if session.has_key?(:date) and session[:date] != ''
      @upcoming_appointments = Appointment.where('date = ?', Time.parse(session[:date]).to_date)
    end
    @paginate = false
    render "appointments/_upcoming", :layout => false
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

  # GET /appointments
  def set_recurring_reminder
   if params.has_key?(:reminder_date) and params.has_key?(:appointment_id)
     @reminder = RecurringReminder.new
     @reminder.notification_date = params[:reminder_date]
     @reminder.appointment_id = params[:appointment_id]
     @reminder.save
   end
  end

  # GET /appointments/new
  def new
    @types = AptType.all
    @appointment = Appointment.new
    @appointment.date = Date.today
    @appointment.time = Time.now
    @residents = Resident.all
    @upcoming_appointments = Appointment.where('date >= ?', Date.today).paginate(:per_page => 10, :page => params[:page])
  end

  def add_apt_type
    if AptType.where('apt_type = ?', params[:apt_type]).empty? and params[:apt_type] != ''
      @type = AptType.new
      @type.update_attribute(:apt_type, params[:apt_type])
      @type.save
    end
    @types = AptType.all
    respond_to do |format|
      format.html
      format.js
    end

  end

  # GET /appointments/1/edit
  def edit
    @types = AptType.all
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    @types = AptType.all
    @residents = Resident.all
    @upcoming_appointments = Appointment.where('date >= ?', Date.today).paginate(:per_page => 10, :page => params[:page])
    respond_to do |format|
      if @appointment.save
        coordinators = User.where(medical_coordinator: true).where(email_pref: true)
        coordinators.each do |coordinator|
          NotificationMailer.new_appointment_notification(@appointment, coordinator).deliver
        end
        if !@appointment.user.nil?
          NotificationMailer.appointment_assignment_notification(@appointment).deliver
        end
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
        if !@appointment.user.nil?
          NotificationMailer.appointment_assignment_notification(@appointment).deliver
        end
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
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def appointments
    @appointments
  end

  def residents
    @residents
  end

  def send_house_reminder
    users = User.where(house: @appointment.resident.house)
    users.each do |user|
      NotificationMailer.house_reminder(@appointment, user).deliver
    end
    if !@appointment.user.nil?
      NotificationMailer.house_reminder(@appointment, @appointment.user).deliver
    end
    redirect_to @appointment, notice: "Emails sent"
  end

  private
  # Check to see if the user is a workstation head
  def check_workstation_head
    redirect_to appointments_path, alert: "Workstation heads may not modify appointments." unless current_user.admin || current_user.house.name != 'Workstation Heads'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def appointment_params
    params.require(:appointment).permit(:resident_id, :doctor_id, :user_id, :date, :time, :apt_type, :notes, :res_id, :house_id, :date, :apt_type,  :cancel)
  end

    def sort_column
    Appointment.column_names.include?(params[:sort]) ? params[:sort] : "resident_id"
    Appointment.column_names.include?(params[:sort]) ? params[:sort] : "doctor_id"
    Appointment.column_names.include?(params[:sort]) ? params[:sort] : "user_id"
    Appointment.column_names.include?(params[:sort]) ? params[:sort] : "date"
    Appointment.column_names.include?(params[:sort]) ? params[:sort] : "time"
    Appointment.column_names.include?(params[:sort]) ? params[:sort] : "apt_type"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
  # Check to see if the user is an admin (staff)
  def check_house
    redirect_to appointments_path, alert: "You do not have admin privileges." unless current_user.admin || current_user.house == @appointment.resident.house
  end

  def check_admin
    redirect_to appointments_path, alert: "You do not have admin privileges." unless current_user.admin
  end

end
