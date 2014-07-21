module Georgia
  module Blog
    class PostsController < Georgia::PagesController

      before_filter :prepare_post_data, only: [:update, :settings]

      private

      def prepare_post_data
        @post_data ||= @page.build_post_data unless @page and @page.post_data
      end

      def permitted_extra_params
        [{ category_list: [] }, { post_data_attributes: [:published_at, :author_id] }]
      end
    end
  end
end