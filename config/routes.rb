DataEngineering::Application.routes.draw do
  root 'uploads#index'

  resources :uploads do
    collection do
      post :import
      get :summary
    end
  end

  resources :transactions
end
