Nightlight::Engine.routes.draw do
  resources :pages do
    member do
      post :assign
      post :unassign
      post :checked
    end
    collection do
      post :add_yes
      post :add_no
      post :random
    end
    resources :activities, only: [:create]
  end
  root to: "pages#index"
end
