Georgia::Engine.routes.draw do

  resources :posts do
    collection do
      post :sort
      get :search
      get "with_tag/:tag", to: :find_by_tag
    end

    member do
      get :preview
      get :draft
      get :publish
      get :unpublish
      get :copy
      get :store
    end

    resources :revisions do
      member do
        get :preview
        get :review
        get :approve
        get :store
        get :decline
        get :unpublish
        get :revert
      end
    end
  end

end