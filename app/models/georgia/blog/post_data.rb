module Georgia
  module Blog
    class PostData < ActiveRecord::Base

      belongs_to :post
      belongs_to :author, class_name: Georgia::User

      def month
        @month ||= published_at.strftime('%B %Y') if published_at.present?
      end

      def year
        @year ||= published_at.year if published_at.present?
      end

    end
  end
end