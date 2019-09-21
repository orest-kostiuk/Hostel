# frozen_string_literal: true

ActiveAdmin.register Month do
  actions :all, except: %i[new edit]
  # menu label: I18n.t('active_admin.menu.items.balance')
  #
  #
  action_item :view, only: :show do
    link_to t('active_admin.user.link.generate_information'), generate_billing_admin_billment_path(month.id), method: :post
  end
end
