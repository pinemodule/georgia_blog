class AddAuthorToGeorgiaPostData < ActiveRecord::Migration
  def change
    add_column :georgia_post_data, :author_id, :integer
    add_index :georgia_post_data, :author_id
  end
end
