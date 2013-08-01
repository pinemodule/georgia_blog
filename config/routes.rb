Georgia::Engine.routes.draw do

  resources :posts do
    collection do
      post :sort
      get :search
      get "with_tag/:tag", to: :find_by_tag
    end

    member do
      get :draft
      get :publish
      get :unpublish
      get :copy
      get :store
      get :details
    end

    resources :drafts, :reviews, :revisions do
      member do
        get :copy
        get :store
        get :draft
        get :review
        get :approve
        get :publish
        get :unpublish
      end
    end
  end

end