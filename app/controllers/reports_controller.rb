
class ReportsController < ApplicationController
    # GET /appointments
    # GET /appointments.json

    def index
      @residents = Resident.all
      @houses = House.all
      @doctors = Doctor.all
    end

    def generate
      @appointments = Appointment.all
      if params[:doctor_id] != ''
        @appointments = @appointments.where('doctor_id = ?', params[:doctor_id])
      end

      if params[:resident_id] != ''
        @appointments = @appointments.where('resident_id = ?', params[:resident_id])
      elsif params[:house_id] != ''
        @appointments = @appointments.joins('LEFT OUTER JOIN residents ON resident_id = residents.id').where('house_id = ?', params[:house_id])
      end

      if params[:date] != ''
        @appointments = @appointments.where('date >= ?', Date.strptime(params[:date], "%m/%d/%Y"))
      end
      if params[:date2] != ''
        @appointments = @appointments.where('date <= ?', Date.strptime(params[:date2], "%m/%d/%Y"))
      end
      if params[:format] == 'PDF'
        pdf = Prawn::Document.new(:page_layout => :landscape)
        pdf.image "#{Rails.root}/app/assets/images/pdf_header.png", width: 400, height: 110, :position => :center
        pdf.move_down 25
        printTable(pdf, @appointments)
        send_data pdf.render, filename: 'Report-'+ Time.now.strftime("%m/%d/%Y") +'.pdf', type: 'application/pdf'
      else
        Gen_CSV(@appointments)
      end
    end

   def create
   end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:resident_id, :doctor_id, :date,:house_id, :date2)
    end

    def printTable(pdf, appointments)
      table_data = [["<b>Date</b>", "<b>Time<b>","<b>Resident<b>", "<b>House<b>", "<b>Volunteer<b>", "<b>Doctor<b>", ]]
      test = appointments.map
      test = test.sort_by {|u| [u.date, u.time]}
      #test = test.sort_by {|u| u.time}
      test.each do |appointment|
        table_data +=
            [[

                 appointment.date.to_formatted_s(:long_ordinal),
                 appointment.time.strftime("%l:%M %p"),
                 if not Resident.where('id = ?', appointment.resident_id).blank?
                   Resident.where('id = ?', appointment.resident_id).first.name
                 end,
                 if not Resident.where('id = ?', appointment.resident_id).blank?
                    id = Resident.where('id = ?', appointment.resident_id).first.house_id
                    if not House.where('id = ?', id).blank?
                      House.where('id = ?', id).first.name
                    end
                 end,
                 if not User.where('id = ?', appointment.user_id).blank?
                   User.where('id = ?', appointment.user_id).first.name
                 end,
                 if not Doctor.where('id = ?', appointment.doctor_id).blank?
                   Doctor.where('id = ?', appointment.doctor_id).first.name
                 end

             ]]
      end
      pdf.table(table_data, :header => true, :cell_style => { :inline_format => true }, \
                :column_widths => {0 => 140, 1 => 70, 2 => 125, 3 => 125, 4 => 125, 5 => 125}, \
                :position => :center, :row_colors => ['DDDDDD', 'FFFFFF'])
    end

    def Gen_CSV(appointments)
      csv_string = CSV.generate do |csv|
        cols = ["Date", "Time", "Co-worker", "Doctor"]
        csv << cols
        app = appointments.map
        app = app.sort_by {|u| [u.date, u.time]}
        app.each do |appointment|
          csv << [appointment.date.to_formatted_s(:long_ordinal),
            appointment.time.strftime("%l:%M %p"),
            if not Resident.where('id = ?', appointment.resident_id).blank?
              Resident.where('id = ?', appointment.resident_id).first.name
            end,
            if not Doctor.where('id = ?', appointment.doctor_id).blank?
              Doctor.where('id = ?', appointment.doctor_id).first.name
            end]
        end
      end
      filename = "Report-#{Time.now.to_date.to_s}.csv"
      send_data(csv_string, :type => 'text/csv; charset=utf-8; header=present', :filename => filename)
    end
end
