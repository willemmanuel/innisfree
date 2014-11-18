class UsersController < ApplicationController

	before_action :set_user, only: [:show]

  # GET /houses
  # GET /houses.json
  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.csv { render text: @users.to_csv }
    end
  end


	def show
    @houses = House.all
  end

  def edit
  end

  # GET /houses/new
  def new
    @user = User.new
    @houses = House.all
  end

	private

    def set_user
      @user = User.find(params[:id])
    end

end
