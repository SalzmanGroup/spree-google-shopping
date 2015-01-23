Deface::Override.new(
  name: "add_google_shopping_data_to_products_menu",
  virtual_path: "spree/admin/shared/_product_tabs",
  insert_bottom: %Q{[data-hook="admin_product_tabs"]},
  disabled: false,
  text: <<-ERB
    <%= content_tag :li, class: ('active' if current == 'Google Shopping Data') do %>
      <%= link_to_with_icon 'google', Spree.t(:google_shopping_data), admin_product_google_shopping_data_path(@product) %>
    <% end if can?(:admin, Spree::Product) %>
  ERB
)
