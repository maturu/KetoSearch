Rails.application.routes.draw do
  get 'review/show' => "review#show"
  get 'review/new' => "review#new"
  get 'review/edit' => "review#edit"
  post 'review/create' => "review#create"
  post 'review/update' => "review#update"
  post 'review/destroy' => "review#destroy"
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  get 'users/show'
  get 'users/profile' => "users#edit"
  post 'users/update' => "users#update"

  get 'ranking/show'
  get 'chart/show' => 'chart#show'
  get 'chart/edit' => 'chart#edit'
  get 'chart/more' => 'chart#more'
  get 'chart/qrcode' => 'chart#qrcode'
  get 'chart/new' => 'chart#new'
  get 'chart/calc' => 'chart#ingredient_calc'
  post 'chart/create' => "chart#create"
  post 'chart/update' => "chart#update"
  post 'chart/destroy' => "chart#destroy"
  get 'search/privacy_policy'
  get 'search/terms'
  root "search#index"
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
