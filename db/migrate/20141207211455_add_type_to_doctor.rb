class AddTypeToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :type, :string
  end
end
