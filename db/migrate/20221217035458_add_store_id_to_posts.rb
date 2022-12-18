class AddStoreIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :store, foreign_key: true
  end
end
