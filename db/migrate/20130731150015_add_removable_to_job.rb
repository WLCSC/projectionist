class AddRemovableToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :removable, :boolean
  end
end
