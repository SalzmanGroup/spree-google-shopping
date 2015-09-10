module Spree
  module Admin
    class GoogleShoppingCategoriesController < Spree::Admin::BaseController
      def index
        @taxonomies = Taxonomy.includes(:taxons).all
      end

      def update_many
        @taxons = Taxon.update(params[:taxons].keys, params[:taxons].values).reject { |t| t.errors.empty? }
        if @taxons.empty?
          flash[:notice] = "Taxons updated"
          redirect_to admin_google_shopping_categories_path
        else
          flash[:error] = "Taxons not updated"
          render :index
        end
      end
    end
  end
end
