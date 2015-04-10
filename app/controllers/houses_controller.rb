class HousesController < ApplicationController
  before_action :set_house, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, except: [:index, :show, :edit, :update]
  before_action :check_privileges, only: [:edit, :update]
  before_action :set_most_recent, ony: [:new]

  # GET /houses
  # GET /houses.json
  def index
    houses = House.all.map
    houses = houses.sort_by{|u| [u.name]}
    @houses = houses
    respond_to do |format|
      format.html
      format.csv { render text: @houses.to_csv }
    end
  end

  # Displays an individual house page
  def show
  end

  # Gets a new house to be filled in
  def new
    @house = House.new
  end

  # Opens a house for changes
  def edit
  end

  # Adds the new house to the database, relating success or error to the user
  def create
    @house = House.new(house_params)

    respond_to do |format|
      if @house.save
        format.html { redirect_to new_house_path, notice: 'House (' + @house.name + ') was successfully created.' }
        format.json { render :show, status: :created, location: @house }
      else
        format.html { render :new }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # Changes a house based on edits, relating success or error back to the user
  def update
    respond_to do |format|
      if @house.update(house_params)
        format.html { redirect_to @house, notice: 'House (' + @house.name + ') was successfully updated.' }
        format.json { render :show, status: :ok, location: @house }
      else
        format.html { render :edit }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # Deletes a house from the database, notifying the user as to what was deleted
  def destroy
    @house.destroy
    respond_to do |format|
      format.html { redirect_to houses_url, notice: 'House (' + @house.name + ') was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Check to see if the user is an admin or if they are in a house that gives them access
    def check_privileges
      redirect_to houses_path, alert: "You do not have admin privileges." unless current_user.admin || current_user.house == @house
    end
    # Check to see if the user is an admin
    def check_admin
      redirect_to houses_path, alert: "You do not have admin privileges." unless current_user.admin
    end

    # Use callbacks to share common setup or constraints between actions
    def set_house
      @house = House.find(params[:id])
    end

    #Finds the most recently created house (for use in navigation)
  def set_most_recent
    @recent = House.order("created_at").last
  end

    # Never trust parameters from the scary internet, only allow the white list through
    def house_params
      params.require(:house).permit(:name, :phone)
    end
end
