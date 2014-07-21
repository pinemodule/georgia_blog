Georgia::Engine.routes.draw do

  Georgia::PageableRouteConcern.included(self)

  namespace :blog do
    resources :posts, concerns: [:pageable]
  end

end