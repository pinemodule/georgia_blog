module Kennedy
  class PostData < ActiveRecord::Base
    attr_accessible :published_at
		belongs_to :post
  end
end
