Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :listings, only: [:show]
    end
  end
end
