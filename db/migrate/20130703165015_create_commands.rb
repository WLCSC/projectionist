class CreateCommands < ActiveRecord::Migration
  def change
    create_table :commands do |t|
      t.string :name
      t.text :notes
      t.text :data

      t.timestamps
    end
  end
end
