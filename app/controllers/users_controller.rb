class UsersController < ApplicationController

  before_filter :check_admin, only: [:edit, :update, :destroy, :new, :create]
	before_action :set_user, only: [:show, :edit, :update, :destroy, :test_email]
  before_action :set_most_recent, ony: [:new]
  helper_method :sort_column, :sort_direction

  # GET /houses
  # GET /houses.json
  def index
    @user = current_user.id
    @users = User.order(sort_column + " " + sort_direction)
    respond_to do |format|
      format.html
      format.csv { render text: @users.to_csv }
      format.pdf do
        pdf = ReportPdf.new(@users)
        send_data pdf.render, filename: 'Report-'+ Time.now.strftime("%d/%m/%Y") +'.pdf', type: 'application/pdf'
      end
    end
  end

  def send_reminders
   User.send_reminders
   redirect_to :back, notice: "Email reminders sent."
  end

	def show
    @houses = House.all
  end

  def edit
    @user = User.find(params[:id])
    @houses = House.all
  end

  def new
    @user = User.new
    @houses = House.all
    respond_to do |format|
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
    end

  end


  def update
    @houses = House.all

    if user_params[:password].blank?
      result = @user.update_without_password(user_params)
    else
      if current_user.id == @user.id
        result = @user.update_with_password(user_params)
      else
        result = @user.update_attributes(user_params)
      end
    end


    respond_to do |format|
      if result
        format.html { redirect_to @user, notice: 'User (' + @user.name + ') was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User (' + @user.name + ') was successfully deleted.' }
      format.json { head :no_content }
    end
  end

	private

    def set_user
      @user = User.find(params[:id])
    end

  def set_most_recent
    @recent = User.order("created_at").last
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :house_id, :phone, :email_pref, :admin)
  end

  def sort_column
    @houses = 
    User.column_names.include?(params[:sort]) ? params[:sort] : "name"
    User.column_names.include?(params[:sort]) ? params[:sort] : "email"
    User.column_names.include?(params[:sort]) ? params[:sort] : "phone"
    User.column_names.include?(params[:sort]) ? params[:sort] : "house_id"
    User.column_names.include?(params[:sort]) ? params[:sort] : "NOT(admin)"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def check_admin
    redirect_to root_path, alert: "You do not have admin privileges." unless current_user.admin || current_user.id == @user.id
  end

end
