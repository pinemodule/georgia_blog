Georgia::Engine.routes.draw do

  concern :pageable do
    collection do
      get :search
      post :sort
      post :publish
      post :unpublish
      post 'flush-cache', to: :flush_cache, as: :flush_cache
      delete '/', to: :destroy
    end

    member do
      get :copy
      get :settings
    end

    resources :revisions do
      member do
        get :preview
        get :review
        get :approve
        get :store
        get :decline
        get :restore
      end
    end
  end

  resources :posts, concerns: [:pageable]

end