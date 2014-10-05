class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.string :name
      t.string :phone
      t.belongs_to :house, index: true

      t.timestamps
    end
  end
end
