class AddImageAndDescriptionToBookCategory < ActiveRecord::Migration[8.0]
  def change
    add_column :book_categories, :image_url, :string
    add_column :book_categories, :description, :string
  end
end
