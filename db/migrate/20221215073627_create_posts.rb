class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :product_img
      t.string :product_introduction
      t.integer :store_id

      t.timestamps
    end
  end
end
