class RemoveBookFromFavorites < ActiveRecord::Migration[6.1]
  def change
    remove_column :favorites, :book_, :integer
  end
end
