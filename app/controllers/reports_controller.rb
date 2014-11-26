class ReportsController < ApplicationController
    # GET /appointments
    # GET /appointments.json
    def index
      @residents = Resident.all
      @houses = House.all
      @doctors = Doctor.all
      if params.has_key?(:res_id)
        session[:res_id] = params[:res_id]
      end
      if params.has_key?(:house_id)
        session[:house_id] = params[:house_id]
      end
      if params.has_key?(:doctor_id)
        session[:doctor_id] = params[:doctor_id]
      end
      if session.has_key?(:res_id) and session[:res_id] != ''
        @appointments = Appointment.joins('LEFT OUTER JOIN doctors ON doctor_id = doctors.id').where('resident_id = ?', session[:res_id])
        respond_to do |format|
          format.html
          format.json
          format.js
          format.csv { render text:@appointments.to_csv }
        end
      elsif session.has_key?(:house_id) and session[:house_id] != ''
        @appointments = Appointment.joins('LEFT OUTER JOIN residents ON resident_id = residents.id').where('house_id = ?', session[:house_id])
        respond_to do |format|
          format.html
          format.json
          format.js
          format.csv { render text:@appointments.to_csv }
        end
      else
        @appointments = Appointment.all
        logger.debug "no params"
        respond_to do |format|
          format.html
          format.json
          format.js
          format.csv { render text:@appointments.to_csv }
        end
      end
    end
end
