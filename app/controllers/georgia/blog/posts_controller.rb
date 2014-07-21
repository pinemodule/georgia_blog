module Georgia
  module Blog
    class PostsController < Georgia::PagesController

      before_filter :prepare_post_data, only: [:update, :settings]

      private

      def prepare_post_data
        @post_data ||= @page.build_post_data unless @page and @page.post_data
      end

      def sanitized_params
        parsed_params = ParseJsonTags.new(post_params).call
        parsed_params = ParseJsonTags.new(parsed_params, key: :category_list).call
        parsed_params
      end

      def post_params
        params.require(:page).permit(permitted_keys + extra_permitted_keys)
      end

      def extra_permitted_keys
        [ :category_list, { post_data_attributes: [:published_at, :author_id] } ]
      end

    end
  end
end