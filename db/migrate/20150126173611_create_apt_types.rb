class CreateAptTypes < ActiveRecord::Migration
  def change
    create_table :apt_types do |t|
      t.string :apt_type

      t.timestamps
    end
  end
end
