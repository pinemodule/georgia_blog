class CreateKennedyPostData < ActiveRecord::Migration
  def change
    create_table :kennedy_post_data do |t|
      t.datetime :published_at
      t.integer :post_id

      t.timestamps
    end
  end
end
