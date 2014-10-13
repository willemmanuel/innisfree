class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :name
      t.belongs_to :volunteer, index: true
      t.string :for

      t.timestamps
    end
  end
end
