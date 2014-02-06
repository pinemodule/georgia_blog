module Georgia
  class PostsController < Georgia::PagesController

    before_filter :prepare_post_data

    private

    def prepare_post_data
      @post_data ||= @page.build_post_data unless @page.post_data
    end
  end
end