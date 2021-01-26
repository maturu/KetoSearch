Rails.application.routes.draw do
  get 'notifications/index' => "notifications#index"
  get 'notifications/attention' => "notifications#attention"
  post 'notifications/check' => "notifications#update"

  get 'store/show' => "store#show"
  get 'store/new' => "store#new"
  get 'store/edit' => "store#edit"
  get 'store/about' => "store#about"
  post 'store/create' => "store#create"
  post 'store/update' => "store#update"
  post 'store/subscribe' => "subscribe#create"
  post 'store/unsubscribe' => "subscribe#destroy"

  get 'review/show' => "review#show"
  get 'review/new' => "review#new"
  get 'review/edit' => "review#edit"
  post 'review/create' => "review#create"
  post 'review/update' => "review#update"
  post 'review/destroy' => "review#destroy"
  post 'review/report' => "review#report"
  post 'review/helpful' => "review#helpful"

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  get 'users/show'
  get 'users/profile' => "users#edit"
  post 'users/update' => "users#update"

  get 'chart/show' => 'chart#show'
  get 'chart/edit' => 'chart#edit'
  get 'chart/more' => 'chart#more'
  get 'chart/qrcode' => 'chart#qrcode'
  get 'chart/new' => 'chart#new'
  get 'chart/calc' => 'chart#calc'
  get 'chart/incremental' => 'chart#incremental'
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
