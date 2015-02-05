Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  namespace :admin do
    resources :google_shopping_integrations
    resources :google_shopping_categories, only: :index do
      collection do
        put :update_many
      end
    end
  end
end
