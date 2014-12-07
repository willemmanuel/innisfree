class AddPhoneToHouse < ActiveRecord::Migration
  def change
    add_column :houses, :phone, :string
  end
end
