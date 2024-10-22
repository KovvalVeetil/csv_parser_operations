Rails.application.routes.draw do
  resources :buildings do
    collection do
      post :upload_csv
    end
  end
  root "buildings#new"
end
