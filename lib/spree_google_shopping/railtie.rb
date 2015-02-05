module SpreeGoogleShopping
  class Railtie < ::Rails::Railtie
    
    rake_tasks do
      load 'spree_google_shopping/tasks.rb'
    end
    
  end
end
