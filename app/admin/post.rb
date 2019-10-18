# frozen_string_literal: true

ActiveAdmin.register Post do
  permit_params :title, :short_description, :body, :admin_user_id, :is_published

  menu label: 'Новини'

  index title: 'Новини' do
    column :title
    column :short_description
    column :body
    column :admin_user
    column :is_published
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :is_published, label: 'Опублікувати?'
      f.input :title, label: 'Заголовок'
      f.input :short_description, label: 'Коротки опис'
      f.input :body, as: :quill_editor, label: 'Опис'
      f.actions
    end
  end

  show do
    attributes_table do
      row :is_published
      row :title
      row :short_description
      row :body
      row :created_at
      row :updated_at
    end
  end
end
