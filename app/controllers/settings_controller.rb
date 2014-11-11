class SettingsController < ApplicationController
	before_filter :check_admin
	before_filter :set_user, only: [:toggle_user_permission, :toggle_user_approval]

	def index
		@users = User.all
	end

	def toggle_user_permission
		@user.toggle!(:admin)
		redirect_to :back, notice: "User toggled"
	end

	def toggle_user_approval
		@user.toggle!(:approved)
		if !@user.approved
			@user.admin = false
			@user.save
		end
		redirect_to :back, notice: "User toggled"
	end

	private

	def check_admin
		redirect_to root_path, alert: "You do not have admin privileges" unless current_user.admin
	end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:settings).permit(:id)
    end
end
