module Georgia
  class PostData < ActiveRecord::Base
    self.table_name = 'kennedy_post_data'

    attr_accessible :published_at

		belongs_to :post
  end
end
