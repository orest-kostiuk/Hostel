ActiveAdmin.register Tenant do
  permit_params :first_name, :surname, :last_name, :index, :region, :district, :city, :street, :house_number,
                :passport_series, :who_issued_the_passport, :when_issued_the_passport, :the_taxpayer_identification_number,
                :phone_number, :login_code, :user_id

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at


  form do |f|
    f.inputs do
      f.input :user
      f.input :first_name
      f.input :surname
      f.input :last_name
      f.input :index
      f.input :region
      f.input :district
      f.input :city
      f.input :street
      f.input :house_number
      f.input :passport_series
      f.input :who_issued_the_passport
      f.input :when_issued_the_passport
      f.input :the_taxpayer_identification_number
      f.input :phone_number
    end
    f.actions
  end

  show do
    attributes_table do
      row :user do |tenant|
        if u = tenant.user
          link_to [u.first_name, u.surname, u.last_name].join(' '), admin_user_path(u)
        end
      end
      row :first_name
      row :surname
      row :last_name
      row :index
      row :region
      row :district
      row :city
      row :street
      row :house_number
      row :passport_series
      row :who_issued_the_passport
      row :when_issued_the_passport
      row :the_taxpayer_identification_number
      row :phone_number
      row :login_code
    end
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :surname
      f.input :last_name
      f.input :index
      f.input :region
      f.input :district
      f.input :city
      f.input :street
      f.input :house_number
      f.input :passport_series
      f.input :who_issued_the_passport
      f.input :when_issued_the_passport
      f.input :the_taxpayer_identification_number
      f.input :phone_number
    end
    f.actions
  end



end
