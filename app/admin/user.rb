ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :first_name

  menu label: I18n.t('active_admin.menu.items.user')

  index :title => 'Користувачі' do
    selectable_column
    id_column
    column t('active_admin.user.column.email')
    column t('active_admin.user.column.current_sign_in_at')
    column t('active_admin.user.column.sign_in_count')
    column t('active_admin.user.column.created_at')
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  member_action :generate_information, method: :post do
  end

  controller do

    def generate_information
      u = User.find(params[:id])
      tenant = GenerateInformation.new(u).process
      redirect_to edit_admin_tenant_path(tenant)
    end
  end



  action_item :view, only: :show, if: proc { !user.tenant } do
    link_to t('active_admin.user.link.generate_information'), generate_information_admin_user_path(user.id), method: :post
  end
end
