class AddEmailReminderPrefrenceToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :email_pref, :boolean, :default => false
  end
end
