Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  get 'users/show'

  get 'ranking/show'
  get 'chart/show' => 'chart#show'
  get 'chart/edit' => 'chart#edit'
  get 'chart/new' => 'chart#new'
  post 'chart/create' => "chart#create"
  post 'chart/update' => "chart#update"
  get 'search/privacy_policy'
  get 'search/terms'
  root "search#index"
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
