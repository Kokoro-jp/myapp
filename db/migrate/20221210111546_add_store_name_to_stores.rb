class AddStoreNameToStores < ActiveRecord::Migration[6.1]
  def change
    add_column :stores, :store_name, :string
    add_column :stores, :store_address, :string
    add_column :stores, :business_hours, :time
  end
end
