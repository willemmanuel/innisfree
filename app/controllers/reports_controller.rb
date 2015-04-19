
class ReportsController < ApplicationController

    before_filter :check_admin

    # GET /appointments
    # GET /appointments.json
    # index page shows all the fields where users can customize their report
    def index
      @residents = Resident.all
      @houses = House.all
      @doctors = Doctor.all
      @appointment_types = AptType.all
    end

    
    # generate the report according to usres' preferences
    def generate
      @appointments = Appointment.all
      if params[:doctor_id] != ''
        @appointments = @appointments.where('doctor_id = ?', params[:doctor_id]) # generate report with regard to specific doctor
      end

      if params[:resident_id] != ''
        @appointments = @appointments.where('resident_id = ?', params[:resident_id]) # generate the report with regard to specific resident
      elsif params[:house_id] != ''
        @appointments = @appointments.joins('LEFT OUTER JOIN residents ON resident_id = residents.id').where('house_id = ?', params[:house_id]) # generate the report with regard to specific house
      end

      if params[:date] != ''
        @appointments = @appointments.where('date >= ?', Date.strptime(params[:date], "%m/%d/%Y")) # select a starting date
      end
      if params[:date2] != ''
        @appointments = @appointments.where('date <= ?', Date.strptime(params[:date2], "%m/%d/%Y")) # select an ending date
      end
      if params[:apt_type] != ''
        @appointments = @appointments.where('apt_type = ?', params[:apt_type]) # generate the report with regard to specific appointment type
      end
      if params[:format] == 'PDF' # if the user choose to generate a PDF report
        pdf = Prawn::Document.new(:page_layout => :landscape) # create a new pdf with predefined layout
        pdf.image "#{Rails.root}/app/assets/images/pdf_header.png", width: 400, height: 110, :position => :center # insert InnIsfree header image
        pdf.move_down 25
        printTable(pdf, @appointments)
        send_data pdf.render, filename: 'Report-'+ Time.now.strftime("%m/%d/%Y") +'.pdf', type: 'application/pdf' # define the name of the pdf file
      else
        Gen_CSV(@appointments) # if the user choose to generate s CSV report
      end
    end

   # POST /reports
   # POST /reports.json
   # allow users to create new reports
   def create
   end


  private

    # check if currently user is an admin or not
    def check_admin
      redirect_to root_path, alert: "You do not have admin privileges." unless current_user.admin
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:resident_id, :doctor_id, :date,:house_id, :date2)
    end

    # populate the pdf report with data
    def printTable(pdf, appointments)
      table_data = [["<b>Date</b>", "<b>Time<b>","<b>Resident<b>", "<b>House<b>", "<b>Volunteer<b>", "<b>Doctor<b>", "<b>Type<b>" ]] # header for each field
      test = appointments.map
      test = test.sort_by {|u| [u.date, u.time]} # sort the appointments by time and date and add them into the report
      #test = test.sort_by {|u| u.time}
      test.each do |appointment|
        if appointment.cancel != true #if the appointment is not cancelled
        table_data += # add each entry into the report
            [[

                 appointment.date.to_formatted_s(:long_ordinal),
                 appointment.time.strftime("%l:%M %p"),
                 if not Resident.where('id = ?', appointment.resident_id).blank? # if the resident exists
                   Resident.where('id = ?', appointment.resident_id).first.name
                 end,
                 if not Resident.where('id = ?', appointment.resident_id).blank?
                    id = Resident.where('id = ?', appointment.resident_id).first.house_id
                    if not House.where('id = ?', id).blank? # if the house exists
                      House.where('id = ?', id).first.name
                    end
                 end,
                 if not User.where('id = ?', appointment.user_id).blank? # if the user exists
                   User.where('id = ?', appointment.user_id).first.name
                 end,
                 if not Doctor.where('id = ?', appointment.doctor_id).blank? # if the doctor exists
                   Doctor.where('id = ?', appointment.doctor_id).first.name
                 end,
                 appointment.apt_type # insert appointment type

             ]]
           end
      end
      pdf.table(table_data, :header => true, :cell_style => { :inline_format => true }, \
                :column_widths => {0 => 140, 1 => 70, 2 => 100, 3 => 100, 4 => 100, 5 => 100, 6 => 100}, \
                :position => :center, :row_colors => ['DDDDDD', 'FFFFFF']) # define the format of the PDF report
    end

    def Gen_CSV(appointments) 
      csv_string = CSV.generate do |csv|
        cols = ["Date", "Time", "Resident", "Volunteer", "Doctor", "Type", "Notes"] # define the header for each field
        csv << cols # for each column
        app = appointments.map
        app = app.sort_by {|u| [u.date, u.time]} # sort all appointments by date and time
        app.each do |appointment|
          if appointment.cancel != true # if the appointment is not cancelled
          csv << [appointment.date.to_formatted_s(:long_ordinal),
            appointment.time.strftime("%l:%M %p"),
            if not Resident.where('id = ?', appointment.resident_id).blank? # if the resident exists
              Resident.where('id = ?', appointment.resident_id).first.name
            end,

            if not User.where('id = ?', appointment.user_id).blank? # if the user exists
              User.where('id = ?', appointment.user_id).first.name
            end,

            if not Doctor.where('id = ?', appointment.doctor_id).blank? # if the doctor exists
              Doctor.where('id = ?', appointment.doctor_id).first.name
            end,
            appointment.apt_type, # insert appointment type
            appointment.notes # insert notes for that appointment 
            ]
          end
        end
      end
      filename = "Report-#{Time.now.to_date.to_s}.csv" # define CSV filename
      send_data(csv_string, :type => 'text/csv; charset=utf-8; header=present', :filename => filename) # generate the cSV file
    end
end
