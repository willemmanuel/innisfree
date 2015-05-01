# The Appointments Controller controls appointments. It is responsible for creating, viewing, editing, canceling and deleting appointments and telling the Mailer to send appointment reminder emails.

class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy, :send_house_reminder] # loads the correct appointment before viewing/updating/destroying/emailing appointments
  before_action :check_workstation_head, only: [:new, :edit, :create, :update, :destroy] # checks if the user is a workstation head before creating/updating/deleting appointments
  before_action :check_admin, only: [:destroy, :send_house_reminder] # checks if the user is an admin before deleting appointments or sending reminder emails
  before_action :check_house, only: [:edit, :update] # checks the user house before editing or updating an appointment
  helper_method :sort_column, :sort_direction # helper methods for sorting

  # GET /appointments
  # GET /appointments.json
  # index - the main page of our web application
  # Checks the request parameters first for certain page parameters, then populates fields on the view with those params if present
  # These params are also used to filter the appointments displayed on the calendar
  def index
    @residents = Resident.all
    @houses = House.all
    @past_appointments = Appointment.where('date < ?', Date.today)
    @upcoming_appointments = Appointment.where('date >= ?', Date.today).order([:date, :time]).paginate( :page => params[:page], :per_page => 10).order(sort_column + " " + sort_direction)
    if params.has_key?(:res_id) # Retrieves the resident_id to filter appointments with, if a resident_id is present
      session[:res_id] = params[:res_id]
    end
    if params.has_key?(:house_id) # Retrieves the house_id to filter appointments with, if a house_id is present
      session[:house_id] = params[:house_id]
      begin
        @house = House.find(session[:house_id])
      rescue
        @house = nil
      end
    end
    
    if (@house != nil and @house.name == "Workstations") or (@house != nil and @house.name == "Office Staff")
      session[:house_id] = ''
    end
    
    if session.has_key?(:res_id) and session[:res_id] != '' # Filters the list of appoinments based on the resident selected by the dropdown selector, if resident is not blank
      @appointments = Appointment.where('resident_id = ?', session[:res_id]) 
      @appointments_counts = @appointments.group("date").count
    elsif session.has_key?(:house_id) and session[:house_id] != '' # Filters list of appointments based on selected house, if house is not blank
      @appointments = Appointment.joins('LEFT OUTER JOIN residents ON resident_id = residents.id').where('house_id = ?', session[:house_id])
      @appointments_counts = @appointments.group("date").count
    else # Return all appointments if no resident or house was selected
      @appointments = Appointment.all
      @appointments_counts = @appointments.group('date').count
    end
    respond_to do |format|
      format.html # Returns the html for the page
      format.json # Format selected appointments as a json file containing appointments to populate calendar
      format.js # Returns the page javascript
      format.csv { render text:@appointments.to_csv } # Allows appointments to be downloaded as a CSV file
    end
  end

  # GET appointments/upcoming - usually called from other page/method
  # upcoming - used to render a table of the upcoming appointments, ordered by appointment date
  # Checks the request parameters first for certain page parameters, then filters the list of upcoming appointments with those params if present
  def upcoming
    if params.has_key?(:res_id) # Checks to see if a resident is specified in the request
      session[:res_id] = params[:res_id]
    end
    if params.has_key?(:house_id) # Checks to see if a house is specified in the request
      session[:house_id] = params[:house_id]
        begin
        @house = House.find(session[:house_id])
      rescue
        @house = nil
      end
    end
    
    if (@house != nil and @house.name == "Workstations") or (@house != nil and @house.name == "Office Staff")
      session[:house_id] = ''
    end
    
    if session.has_key?(:res_id) and session[:res_id] != '' # Selects upcoming appointments based on specified resident and orders them by date
      @upcoming_appointments = Appointment.where('resident_id = ?', session[:res_id]).order([:date, :time]).where('date >= ?', Date.today).paginate(:per_page => 10, :page => params[:page])
    elsif session.has_key?(:house_id) and session[:house_id] != '' # Selects upcoming appointments based on specified house and orders them by date
      @upcoming_appointments = Appointment.joins('LEFT OUTER JOIN residents ON resident_id = residents.id').where('house_id = ?', session[:house_id]).where('date >= ?', Date.today).order([:date, :time]).paginate(:per_page => 10, :page => params[:page])
    else # Selects all upcoming appointments and orders them by date
      @upcoming_appointments = Appointment.where('date >= ?', Date.today).order([:date, :time]).paginate(:per_page => 10, :page => params[:page])
    end
    @paginate = true #paginate variable is used in view to determine whether the table used to display appointments is one page with all appointments, or many pages, each with 10 appointments
    render "appointments/_upcoming", :layout => false # _upcoming is a partial used to format the appointment list as a table of upcoming appointments
  end

  # GET appointments/appointments_for_day - usually called from other page/method
  # appointments_for_day - provides a list of that day's appointments, for daily email reminders, in a table view
  def appointments_for_day
    if params.has_key?(:date) # allows for filtering by date
      session[:date] = params[:date]
    end
    if params.has_key?(:res_id) # allows for filtering by resident
      session[:res_id] = params[:res_id]
    end
    if params.has_key?(:house_id) # allows for filtering by house
      session[:house_id] = params[:house_id]
    end
    if session.has_key?(:date) and session[:date] != '' # gets the appointments filtered by above parameters
      @upcoming_appointments = Appointment.where('date = ?', Time.parse(session[:date]).to_date).order([:date, :time]).paginate(:per_page => 10, :page => params[:page])
    end
    @paginate = false # Display these as a single page, with as many appointments in the table as are happening
    render "appointments/_upcoming", :layout => false # _upcoming is a partial used to format the appointment list as a table of upcoming appointments
  end

  # GET /appointments
  # GET /appointments.json
  # update_residents - updates the residents available in the resident dropdown menu when the house dropdown value is changed
  # Not a URL called directly, as it depends on being called asynchronously from the main appointments page
  def update_residents
    if (params[:house_id] != '')
      @residents = Resident.where("house_id = ?", params[:house_id]) # selects the residents in that house
    else
      @residents = Resident.all # selects all residents if no house is selected
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /appointments/1
  # GET /appointments/1.json
  # show - shows an individual appointment
  def show
  end

  # GET /appointments
  # set_recurring_reminder - used to set a reminder that an appointment is recurring and will need to be scheduled again in the future
  def set_recurring_reminder
   if params.has_key?(:reminder_date) and params.has_key?(:appointment_id)
     @reminder = RecurringReminder.new
     @reminder.notification_date = params[:reminder_date] # date when a reminder will be sent
     @reminder.appointment_id = params[:appointment_id] # appointment that reminder is set for
     @reminder.save # saves the reminder in the database
   end
  end

  # GET /appointments/new
  # new - populates data fields needed to create a new appointment
  def new
    @types = AptType.all.order(apt_type: :asc) 
    @appointment = Appointment.new
    @appointment.date = Date.today
    @appointment.time = Time.now
    @residents = Resident.all.order(name: :asc)
    @upcoming_appointments = Appointment.where('date >= ?', Date.today).order([:date, :time]).paginate(:per_page => 10, :page => params[:page])
  end

  # GET /appointments/add_apt_type
  # add_apt_type - allows for adding a new appointment type and then updates the displayed list of appointment types
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
  # edit - populates data fields needed to edit an appointment
  def edit
    @types = AptType.all
  end

  # POST /appointments
  # POST /appointments.json
  # create - POSTed to when the "Create Appointment" button is clicked after filling out a new appointment
  # Saves appointment data, where it is validated in the model, and sends email notifications to associated users and medical coordinators
  # Also populates fields needed for main page (where we are routed if appointment is saved correctly)
  # On failure, it will remain on the new page and tell the user what errors are present
  def create
    @appointment = Appointment.new(appointment_params)
    @types = AptType.all.order(apt_type: :asc)
    @residents = Resident.all.order(name: :asc)
    @upcoming_appointments = Appointment.where('date >= ?', Date.today).order([:date, :time]).paginate(:per_page => 10, :page => params[:page])
    respond_to do |format|
      if @appointment.save # if there are no errors in the appointment data
        coordinators = User.where(medical_coordinator: true).where(email_pref: true) # get a list of medical coordinators...
        coordinators.each do |coordinator|
          NotificationMailer.new_appointment_notification(@appointment, coordinator).deliver # ... and email all of them!
        end
        if !@appointment.user.nil? # if a user was associated with the appointment, email them as well
          NotificationMailer.appointment_assignment_notification(@appointment).deliver
        end
        format.html { redirect_to @appointment, notice: 'Appointment was successfully created.' } # redirects browser to main appointments page, and notifies them the appointment was created successfully
        format.json { render :show, status: :created, location: @appointment }
      else # if there are errors in the appointment data tell the user what errors are present
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  # update - PATCH/PUTed to when the "Update Appointment" button is clicked on the appointment edit page
  # Saves appointment data, where it is validated in the model, and sends email notifications to associated users
  # Also populates fields needed for main page (where we are routed if appointment is updated correctly)
  # On failure, it will remain on the edit page and tell the user what errors are present
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        if !@appointment.user.nil? # emails associated users to let them know that the appointment was updated
          NotificationMailer.appointment_assignment_notification(@appointment).deliver
        end
        format.html { redirect_to @appointment, notice: 'Appointment was successfully updated.' } # redirects browser to main appointments page, and notifies them the appointment was created successfully
        format.json { render :show, status: :ok, location: @appointment }
      else # if there are errors in the appointment data tell the user what errors are present
        @types = AptType.all
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  # destroy - used to delete an appointment. Redirects to main appointment page and shows the user a success message
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

  # POST /appointments/:id/send_house_reminder
  # send_house_reminder - used to send an appointment reminder to the users whose resident has an appointment 
  def send_house_reminder
    users = User.where(house: @appointment.resident.house) # gets the users in the same house as the resident
    users.each do |user| # sends an email reminder for each user in that house
      NotificationMailer.house_reminder(@appointment, user).deliver
    end
    if !@appointment.user.nil? # sends an additional reminder to the user associated with the appointment
      NotificationMailer.house_reminder(@appointment, @appointment.user).deliver
    end
    redirect_to @appointment, notice: "Emails sent"
  end

  private
  # check_workstation_head - Check to see if the user is a workstation head
  # This is done because workstation heads are not allowed to modify appointments, unless they are also admin users
  def check_workstation_head
    redirect_to appointments_path, alert: "Workstation heads may not modify appointments." unless current_user.admin || current_user.house.name != 'Workstations'
  end

  # set_appointment - gets the current appointment based on id
  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  # appointment_params - define the exact parameters for each appointment
  # Never trust parameters from the scary internet, only allow the white list through.
  def appointment_params
    params.require(:appointment).permit(:resident_id, :doctor_id, :user_id, :date, :time, :apt_type, :notes, :res_id, :house_id, :date, :apt_type,  :cancel)
  end

  # sort_column - defines how appointments are sorted
  def sort_column
    Appointment.column_names.include?(params[:sort]) ? params[:sort] : "resident_id"
    Appointment.column_names.include?(params[:sort]) ? params[:sort] : "doctor_id"
    Appointment.column_names.include?(params[:sort]) ? params[:sort] : "user_id"
    Appointment.column_names.include?(params[:sort]) ? params[:sort] : "date"
    Appointment.column_names.include?(params[:sort]) ? params[:sort] : "time"
    Appointment.column_names.include?(params[:sort]) ? params[:sort] : "apt_type"
  end

  # sort_direction - defines how items are sorted. If an order is specified it will sort them that way, otherwise it defaults to ascending
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
  # check_house - Check to see if the user has permissions to create or modify an appointment
  # The user will have permission if they are in the same house as the resident associated with that appointment
  def check_house
    redirect_to appointments_path, alert: "You do not have admin privileges." unless current_user.admin || current_user.house == @appointment.resident.house
  end

  #check_admin - checks to see if the user is an admin used based on their account type
  def check_admin
    redirect_to appointments_path, alert: "You do not have admin privileges." unless current_user.admin
  end

end
