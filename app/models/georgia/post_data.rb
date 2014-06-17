module Georgia
  class PostData < ActiveRecord::Base

    belongs_to :post
    belongs_to :author, class_name: Georgia::User

    attr_accessible :published_at, :author_id

    def month
      @month ||= published_at.strftime('%B %Y') if published_at.present?
    end

    def year
      @year ||= published_at.year if published_at.present?
    end

  end
end