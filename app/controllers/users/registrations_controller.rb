class Users::RegistrationsController < Devise::RegistrationsController

  def new
  	@houses = House.all
  	super
  end

  def update
    @houses = House.all
    super
  end

  def edit

    @houses = House.all
    super
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :house_id, :phone)
  end
 
  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :house_id, :phone)
  end

end
