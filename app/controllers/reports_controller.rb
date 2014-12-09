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
      flash[:success] = "Report generated successfully"
      redirect_to Report#index
    end

   def create
   end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:resident_id, :doctor_id, :date,:house_id, :date2)
    end

end
