Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :houses do
    collection { post :import }
  end
  resources :productions do
    collection { post :import }
  end
end
