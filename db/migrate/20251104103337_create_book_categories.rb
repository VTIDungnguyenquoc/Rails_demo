class CreateBookCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :book_categories do |t|
      t.integer :user_id
      t.string :name

      t.timestamps
    end
  end
end
