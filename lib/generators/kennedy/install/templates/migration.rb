class CreateKennedyModels < ActiveRecord::Migration

  def change

    # Create Posts
    create_table :kennedy_posts do |t|
      t.string    :template, default: 'one-column'
      t.string    :slug
      t.integer   :position
      t.integer   :revision_id
      t.integer   :published_by_id
      t.integer   :created_by_id
      t.integer   :updated_by_id
      t.datetime  :published_at
      t.integer   :status_id
      t.string    :ancestry
      t.timestamps
    end
    add_index :kennedy_posts, :published_by_id
    add_index :kennedy_posts, :created_by_id
    add_index :kennedy_posts, :updated_by_id
    add_index :kennedy_posts, :status_id
    add_index :kennedy_posts, :revision_id

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