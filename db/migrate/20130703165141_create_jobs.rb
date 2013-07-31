class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :screen_id
      t.integer :command_id
      t.text :arguments
      t.integer :user_id
      t.datetime :target

      t.timestamps
    end
  end
end
