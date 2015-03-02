class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :medical_coodinator, :medical_coordinator
  end
end
