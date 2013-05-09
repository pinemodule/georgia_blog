class CreateKennedyCategories < ActiveRecord::Migration

  def change

    # Create Categories
    create_table :kennedy_categories do |t|
      t.string :name
      t.string :slug
      t.string :ancestry
      t.timestamps
    end
    add_index :kennedy_categories, :ancestry

    # Create Categories/Posts Association
    create_table :categories_posts, id: false do |t|
      t.integer :category_id
      t.integer :post_id
    end
    add_index :categories_posts, [:category_id, :post_id]

  end
end