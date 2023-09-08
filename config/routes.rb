Rails.application.routes.draw do
  get 'ingredients/new'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'recipes#public'
  get '/public_recipes', to: 'recipes#public'
  get '/general_shopping_list', to: 'shopping_list#index', as: 'general_shopping_list'

  devise_scope :user do
    get "/custom_sign_out" => "devise/sessions#destroy", as: :custom_destroy_user_session
  end

  scope :recipes do
    get '/:id/publish', to: 'recipes#publish', as: :publish_recipe
  end

  scope :recipe_foods do
    delete '/:id/delete', to: 'recipe_foods#destroy', as: :delete_recipe_food
  end

  resources :recipes, shallow: true, except: [:edit, :update] do
    member do
      post 'publish'
    end
  end
  resources :foods, only: [:index, :destroy, :new, :create]
  resources :recipe_foods, only: [:new, :create, :destroy, :edit, :update]
end
