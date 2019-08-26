Rails.application.routes.draw do

  namespace :api do
  get 'check_please', to: 'products#checkout'

  post 'products', to: 'products#create'
  get 'products', to: 'products#index'
  get 'products/:product_code', to: 'products#show'
  put 'products', to: 'products#update'
  delete 'products/:product_code', to: 'products#destroy'

  post 'discounts', to: 'discount#create'
  get 'discounts', to: 'discount#index'
  get 'discounts/:product_code', to: 'discount#show'
  put 'discounts', to: 'discount#update'
  delete 'discounts/:product_code', to: 'discount#destroy'
  end
end
