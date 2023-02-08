class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts, options: 'ROW_FORMAT=DYNAMIC' do |t|
      t.string :product_img
      t.string :product_introduction
      t.integer :store_id

      t.timestamps
    end
  end
end
