class AddHouseIdToUser < ActiveRecord::Migration
  def change
  	add_column :users, :phone, :string
  	add_column :users, :house_id, :integer
  	add_column :users, :name, :string
  end
end
