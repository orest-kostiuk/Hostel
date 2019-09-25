# frozen_string_literal: true

Rails.application.routes.draw do
  mount Tolk::Engine => '/tolk', :as => 'tolk'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'home#index'
  resources :balances
  resources :home do
    member do
      delete :delete_image_attachment
    end
  end
end
