class AddAddressToScreen < ActiveRecord::Migration
  def change
    add_column :screens, :address, :string
  end
end
