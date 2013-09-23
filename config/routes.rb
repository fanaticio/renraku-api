require 'genghis'
Renraku::Application.routes.draw do
  # TODO: scopes it behind authentication
  mount Genghis::Server.new, at: '/genghis'

  api vendor_string: 'renraku', default_version: 1, path: '', defaults: { format: :json } do
    version 1 do
      cache as: 'v1' do
        resources :users, only: :create
        resources :organizations, only: :show do
          resources :templates, only: :create
        end
      end
    end
  end
end
