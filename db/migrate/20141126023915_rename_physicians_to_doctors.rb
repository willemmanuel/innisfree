class RenamePhysiciansToDoctors < ActiveRecord::Migration
  def change
    rename_table :physicians, :doctors
  end
end
