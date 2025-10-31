Zenbook::Engine.routes.draw do
  resources :books do
    resources :pages, shallow: true do
      member do
        patch :publish
      end
    end
    resources :book_subscriptions, only: [:create]
  end
end
