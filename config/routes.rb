Rails.application.routes.draw do
  get 'users/show'
  root to: 'homes#top'
  get "about" => "homes#about" , as: "about"
  get '/:username' => 'users#show'
  devise_for :users
  resources :books
  resources :users, only: [:index, :show, :edit, :update]
  resources :post_images, only: [:new, :destroy]
end
