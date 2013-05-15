module Kennedy
  class PostsController < Kennedy::ApplicationController

    include Georgia::Concerns::Pageable
    include Georgia::Concerns::Publishable
    include Georgia::Concerns::Searchable

    load_and_authorize_resource class: Kennedy::Post

    private

    # Adds to search block called from Concerns::Searchable
    def extra_search_params
      Proc.new {
        facet :month, :categories
        with(:month, params[:m]) unless params[:m].blank?
        with(:categories, params[:c]) unless params[:t].blank?
      }
    end

  end

end