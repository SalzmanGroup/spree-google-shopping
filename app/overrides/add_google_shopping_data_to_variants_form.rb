Deface::Override.new(
  name: "add_google_shopping_data_to_variants_form",
  virtual_path: "spree/admin/variants/_form",
  insert_after: %Q{[data-hook="admin_variant_form_additional_fields"]+.clear},
  disabled: false,
  text: <<-ERB
    <%= render 'google_shopping_data_fields', f: f %>  
  ERB
)
