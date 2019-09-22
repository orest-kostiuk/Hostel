# frozen_string_literal: true

ActiveAdmin.register Block do
  permit_params :side

  menu label: I18n.t('active_admin.menu.items.block')

  filter :floor, collection: lambda {
    Floor.all.map { |f| ["#{f.side == 'left' ? 'Ліве' : 'Праве'}-#{f.number}", f.id] }
  }

  index title: 'Блоки' do
    selectable_column
    column t('active_admin.user.column.number') do |b|
      link_to b.number, admin_block_path(b)
    end
    column t('active_admin.blocks.small_room') do |b|
      room = b.rooms.where(room_type: 'small').first
      link_to "#{b.number} 2м (#{room.available? ? 'Доступна' : 'Не доступна'})", admin_room_path(room)
    end
    column t('active_admin.blocks.big_room') do |b|
      room = b.rooms.where(room_type: 'big').first
      link_to "#{b.number} 3м (#{room.available? ? 'Доступна' : 'Не доступна'})", admin_room_path(room)
    end
    actions
  end

  show do
    attributes_table do
      row :floor do |block|
        if f = block.floor
          link_to f.side, admin_floor_path(f)
        end
      end
      row :number
      row :created_at
      row :updated_at
    end
    panel "Кімнати" do
      table_for block.rooms do
        column :id
        column :status do |room|
          room.available? ? 'Доступна' : 'Не доступна'
        end
        column :room_type do |room|
          room.small? ? '2m' : '3m'
        end
        column :active_orders do |room|
          tenants = room.tenant_orders.where(order_status: 'ordered').map(&:tenant)
          array =  tenants.map { |t| "<br>#{link_to (t.full_name_present? ? [t.last_name,
                                                                             t.first_name, t.surname].join(' ') : t.to_s),
                                                    admin_tenant_path(t)} місць(#{t.tenant_orders.last.count_places})" }
          array[0] = array[0].split('<br>').last if array[0]
          raw array.to_sentence
        end
        column :visit do |room|
          link_to 'Переглянути', admin_room_path(room)
        end
      end
    end
  end
end
