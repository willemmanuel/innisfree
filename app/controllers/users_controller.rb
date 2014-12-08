class UsersController < ApplicationController

	before_action :set_user, only: [:show, :edit, :update, :destroy, :test_email]

  # GET /houses
  # GET /houses.json
  def index
    @user = current_user.id
    @users = User.all
    respond_to do |format|
      format.html 
      format.csv { render text: @users.to_csv }
      format.pdf do
        pdf = ReportPdf.new(@users)
        send_data pdf.render, filename: 'Report-'+ Time.now.strftime("%d/%m/%Y") +'.pdf', type: 'application/pdf'
      end
    end
  end

	def show
    @houses = House.all
  end

  def edit
    @user = User.find(params[:id])
    @houses = House.all
  end

  # GET /houses/new
  def new
    @user = User.new
    @houses = House.all
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
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
      format.html { redirect_to users_url, notice: 'User was successfully deleted.' }
      format.json { head :no_content }
    end
  end

	private

    def set_user
      @user = User.find(params[:id])
    end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :house_id, :phone)
  end

end
