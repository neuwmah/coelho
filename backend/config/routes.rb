Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "health", to: "health#show"
      resources :projects, only: %i[index show]
      resource :bio, only: %i[show]
      resource :contact, only: %i[show create]
      resources :contact_channels, only: %i[index]
      resources :experiences, only: %i[index]
    end
  end
end
