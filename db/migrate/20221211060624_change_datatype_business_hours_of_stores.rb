class ChangeDatatypeBusinessHoursOfStores < ActiveRecord::Migration[6.1]
  def change
    change_column :stores, :business_hours, :string
  end
end
