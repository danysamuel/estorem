Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'store#index', as: 'home'

  resources :products

   resources :inventory do
    collection do
      get :syncdata
    end
  end
  
end
