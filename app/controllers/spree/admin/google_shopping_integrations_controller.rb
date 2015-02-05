module Spree
  module Admin
    class GoogleShoppingIntegrationsController < ResourceController
      def index
        @google_shopping_integrations = GoogleShoppingIntegration.all
      end
    end
  end
end
