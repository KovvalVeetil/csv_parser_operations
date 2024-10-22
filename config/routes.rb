Rails.application.routes.draw do
  resources :buildings, only: [:index, :new] do
    collection do
      post :upload_csv
    end
  end
  root "buildings#new"
end
