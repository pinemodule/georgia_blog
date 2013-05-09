module Kennedy
  class PostsController < Kennedy::ApplicationController

    include Georgia::Concerns::Pageable
    include Georgia::Concerns::Publishable

    load_and_authorize_resource class: Kennedy::Post

  end

end