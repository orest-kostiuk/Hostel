# frozen_string_literal: true

ActiveAdmin.register Month do
  menu label: I18n.t('active_admin.menu.items.month')

  actions :all, except: %i[new edit]

  action_item :view, only: :show do
    link_to t('active_admin.user.link.generate_information'), generate_billing_admin_billment_path(month.id), method: :post
  end

 index title: 'Місяці' do
   selectable_column
   column :id
   column :count_billments do |m|
     m.billments.count
   end
   column t('active_admin.user.column.name'), :name
   column t('active_admin.months.created_at'), :created_at
   column t('active_admin.months.updated_at'), :updated_at
   actions
 end

  show do
    panel "Оплати" do
      table_for month.billments do
        column :ready_billings do |b|
          b.ready_billings.count
        end
        column :created_at
        column :visit do
          link_to 'Переглянути', admin_billment_path
        end
      end
    end
    panel "Виставлені рахунки" do
      table_for month.billments.map { |b| b.ready_billings }.flatten do
        column :amount
        column :tenant do |ready_billing|
          if u = ready_billing.tenant
            link_to (u.full_name_present? ? [u.last_name, u.first_name,
                                             u.surname].join(' ') : u.to_s), admin_tenant_path(u)
          end
        end
        column :created_at
        column :visit do |rb|
          link_to 'Переглянути', admin_ready_billing_path(rb)
        end
      end
    end
  end
end
