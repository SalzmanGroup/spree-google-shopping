Deface::Override.new(:virtual_path => "spree/admin/shared/_configuration_menu",
                     :name => "add_google_shopping_categories_to_admin_configuration_sidebar",
                     :insert_bottom => "[data-hook='admin_configurations_sidebar_menu'], #admin_configurations_sidebar_menu[data-hook]",
                     :text => "<%= configurations_sidebar_menu_item Spree.t('google_shopping_categories'), admin_google_shopping_categories_path %>",
                     :disabled => false)
