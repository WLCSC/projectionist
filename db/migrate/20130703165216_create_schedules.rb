class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :screen_id
      t.integer :command_id
      t.text :arguments
      t.integer :user_id
      t.integer :offset

      t.timestamps
    end
  end
end
