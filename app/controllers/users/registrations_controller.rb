class Users::RegistrationsController 

  def new
    @houses = House.all
  end

  def update
    @houses = House.all
  end

  def edit
    @houses = House.all
  end

  private

  # Defines the parameters needed to create a user
  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :house_id, :phone)
  end
 
  # Defines the parameters permitted to update a user
  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :house_id, :phone)
  end

end
