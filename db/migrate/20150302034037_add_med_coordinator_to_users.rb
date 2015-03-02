class AddMedCoordinatorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :medical_coordinator, :boolean, :default => false
  end
end
