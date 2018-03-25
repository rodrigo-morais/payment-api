Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  defaults format: :json do
    resources :transactions, only: [:index, :show]
    resources :health, only: [:index]
  end
end
