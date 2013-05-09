Kennedy::Engine.routes.draw do

  resources :posts do
    collection do
      post :sort
      get :search
      get "with_tag/:tag", to: "pages#find_by_tag"
    end
    member do
      get :ask_for_review
      get :publish
      get :unpublish
    end
  end

  resources :categories

end