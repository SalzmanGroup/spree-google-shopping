module Spree
  module Admin
    class GoogleShoppingIntegrationsController < ResourceController

      alias update original_update
      def update
        Rails.logger.info "Here are the params #{params.inspect}"
        original_update
      end

      def index
        @google_shopping_integrations = GoogleShoppingIntegration.all
      end
    end
  end
end
