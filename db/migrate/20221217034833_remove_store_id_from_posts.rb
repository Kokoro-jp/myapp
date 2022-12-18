class RemoveStoreIdFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :store_id, :integer
  end
end
