Deface::Override.new(
  name: "add_google_shopping_data_to_products_form",
  virtual_path: "spree/admin/products/_form",
  insert_bottom: %Q{[data-hook="admin_product_form_additional_fields"]},
  disabled: false,
  text: <<-ERB
    <% unless @product.has_variants? %>
      <%= render 'spree/admin/variants/google_shopping_data_fields', f: f %>  
    <% end %>
  ERB
)
