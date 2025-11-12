Zenbook::Engine.routes.draw do
  resources :books do
    resources :pages, shallow: true do
    end
    resources :book_subscriptions, only: [:create, :update, :destroy]
  end

  namespace :read do
    resources :books, only: [:index, :show] do
      member do
        get 'show_toc'
        get 'hide_toc'
      end
    end
    resources :pages, only: [:show]
  end
end
