Kennedy::Engine.routes.draw do

  scope '/admin' do
    resources :posts do
      collection do
        post :sort
        match :search
      end
      member do
        match :preview
        match :ask_for_review
        match :publish
        match :unpublish
      end
    end

    resources :categories
    resources :comments
  end

  post '/posts/:id/preview', to: 'posts#preview', as: :preview_post

end