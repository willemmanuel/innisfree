class CreateResidents < ActiveRecord::Migration
  def change
    create_table :residents do |t|
      t.string :name
      t.belongs_to :house, index: true
      t.text :notes

      t.timestamps
    end
  end
end
