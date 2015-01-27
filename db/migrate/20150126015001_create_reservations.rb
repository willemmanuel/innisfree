class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.datetime :start
      t.datetime :end
      t.belongs_to :user
      t.belongs_to :car

      t.timestamps
    end
  end
end
