class SettingsController < ApplicationController
	before_filter :check_admin
	before_filter :set_user, only: [:toggle_user_permission, :toggle_user_approval, :toggle_user_email_preference, :toggle_user_medical_coordinator]

	def index
		@users = User.all
		@houses = House.all
	end

	def create_user
		@user = User.new(user_params)
		@user.approved = true
		if @user.save
          redirect_to :back, notice: 'User (' + @user.name + ') was successfully created.'
      	else
        	redirect_to :back, alert: 'There were errors present.'
      end
	end

	def toggle_user_permission
		@user.toggle!(:admin)
		redirect_to :back, notice: "User (" + @user.name + ") admin status changed."
  end

  def toggle_user_email_preference
    @user.toggle!(:email_pref)
    redirect_to :back, notice: "User (" + @user.name + ") email preference changed."
  end

  def toggle_user_medical_coordinator
    @user.toggle!(:medical_coordinator)
    redirect_to :back, notice: "User (" + @user.name + ") medical coordinator status changed."
  end

	def toggle_user_approval
		@user.toggle!(:approved)
		if !@user.approved
			@user.admin = false
			@user.save
		end
		redirect_to :back, notice: "User (" + @user.name + ") approval staus changed."
	end

	private

	def check_admin
		redirect_to root_path, alert: "You do not have admin privileges." unless current_user.admin
	end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:name, :email, :phone, :password, :password_confirmation, :house_id)
    end
end
