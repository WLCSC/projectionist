class CreateInstallations < ActiveRecord::Migration
  def change
    create_table :installations do |t|
      t.integer :screen_id
      t.integer :command_id

      t.timestamps
    end
  end
end
