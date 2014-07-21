class AddAuthorToGeorgiaBlogPostData < ActiveRecord::Migration
  def change
    add_column :georgia_blog_post_data, :author_id, :integer
    add_index :georgia_blog_post_data, :author_id
  end
end
