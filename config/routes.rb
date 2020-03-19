Rails.application.routes.draw do
  get 'ranking/show'
  get 'chart/show'
  get 'search/privacy_policy'
  root "search#index"
end
