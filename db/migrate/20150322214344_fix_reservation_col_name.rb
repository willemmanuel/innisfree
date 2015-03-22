class FixReservationColName < ActiveRecord::Migration
  def change
  	rename_column :reservations, :end, :finish
  end
end