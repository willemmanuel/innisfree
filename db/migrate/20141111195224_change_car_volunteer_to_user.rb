class ChangeCarVolunteerToUser < ActiveRecord::Migration
  def change
  	rename_column :cars, :volunteer_id, :user_id
  end
end
