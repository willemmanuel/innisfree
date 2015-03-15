class AptTypesController < ApplicationController
  def destroy
    @typ = AptType.find(params[:id])
    @typ.destroy
    redirect_to new_appointment_path
  end
end
