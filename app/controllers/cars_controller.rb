class CarsController < ApplicationController
  before_filter :check_admin, only: [:edit, :update, :destroy, :new, :create, :manage]
  before_action :set_car, only: [:show, :edit, :update, :destroy, :toggle]
  before_action :set_reservation, only: [:show_reservation, :destroy_reservation]

  # GET /cars
  # GET /cars.json 
  def index
  end

  def manage
    @cars = Car.all
  end

  def get_reservations
    @reservations = Reservation.all
    respond_to do |format|
      format.html
      format.json
      format.js
    end
  end

  def show_reservation
  end

  def get_availability
    parsed_start = Time.zone.parse(params[:reservation_start])
    parsed_end = Time.zone.parse(params[:reservation_end])
    if parsed_start > parsed_end || parsed_start < Time.now
      redirect_to new_reservation_path, notice: "Invalid reservation times"
    end
    @cars = Array.new
    Car.all.each do |car|
      flag = true
      car.reservations.each do |reservation|
        if (parsed_start < reservation.start && parsed_end > reservation.start) || (reservation.start < parsed_start && reservation.end > parsed_start) || (reservation.start == parsed_start && reservation.end == parsed_end)
          flag = false
          break
        end
      end
      if flag 
        @cars << car
      end
    end
    if @cars.empty?
      redirect_to new_reservation_path, method: :post, notice: "No cars available at that time"
    end
    @reservation = Reservation.new
    @reservation.start = params[:reservation_start]
    @reservation.end = params[:reservation_end]
  end

  def new_reservation
    @reservation = Reservation.new
    @cars = Car.all
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  def save_reservation
    @reservation = Reservation.new
    @reservation.start = params[:reservation_start]
    @reservation.end = params[:reservation_end]
    @reservation.car_id = params[:car]
    @reservation.note = params[:note]
    @reservation.user = current_user
    if @reservation.save
      redirect_to action: "index", notice: "Reservation created"
    else
      redirect_to new_reservation_path, notice: "There was an issue creating your reservation"
    end
  end

  def destroy_reservation
    @reservation.destroy
    redirect_to cars_url, notice: 'Reservation was deleted.' 
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)
    respond_to do |format|
      if @car.save
        format.html { redirect_to cars_path, notice: 'Car (' + @car.name + ') was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Car (' + @car.name + ') was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car (' + @car.name + ') was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def toggle
    if @car.user.nil?
      @car.user = current_user
      @car.for = params[:for]
    else
      @car.user = nil
      @car.for = nil
    end
    @car.save
    redirect_to :back, notice: 'Car status toggled'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:name, :user_id, :for)
    end

    def reservation_params
      params.require(:reservation).permit(:start, :end, :car, :note)
    end

    def check_admin
      redirect_to root_path, alert: "You do not have admin privileges." unless current_user.admin
    end

end
