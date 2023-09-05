Rails.application.routes.draw do
  get 'ingredients/new'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'recipes#public'
  get '/public_recipes', to: 'recipes#public'

  resources :recipes, shallow: true, except: [:edit, :update] do
    resources :ingredients, only: [:new, :create, :destroy, :edit, :update]
    member do
      post 'publish'
    end
  end
  resources :foods, only: [:index, :destroy]
  get '/general_shopping_list', to: 'shopping_list#index', as: 'general_shopping_list'
end
