class CreateGeorgiaBlogPostData < ActiveRecord::Migration
  def change
    create_table :georgia_blog_post_data do |t|
      t.datetime :published_at
      t.references :post, index: true

      t.timestamps
    end
  end
end
