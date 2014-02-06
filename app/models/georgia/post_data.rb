module Georgia
  class PostData < ActiveRecord::Base

    belongs_to :post

    attr_accessible :published_at

    def month
      @month ||= published_at.strftime('%B %Y') if published_at.present?
    end

    def year
      @year ||= published_at.year if published_at.present?
    end

  end
end