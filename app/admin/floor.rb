# frozen_string_literal: true

ActiveAdmin.register Floor do
  permit_params :side

  menu label: I18n.t('active_admin.menu.items.floor')

  scope I18n.t('active_admin.user.column.floor_1') do
    Floor.where(number: 1)
  end

  scope I18n.t('active_admin.user.column.floor_2') do
    Floor.where(number: 2)
  end

  scope I18n.t('active_admin.user.column.floor_3') do
    Floor.where(number: 3)
  end

  scope I18n.t('active_admin.user.column.floor_4') do
    Floor.where(number: 4)
  end

  scope I18n.t('active_admin.user.column.floor_5') do
    Floor.where(number: 5)
  end

  scope I18n.t('active_admin.user.column.floor_6') do
    Floor.where(number: 6)
  end

  scope I18n.t('active_admin.user.column.floor_7') do
    Floor.where(number: 7)
  end

  scope I18n.t('active_admin.user.column.floor_8') do
    Floor.where(number: 8)
  end

  scope I18n.t('active_admin.user.column.floor_9') do
    Floor.where(number: 9)
  end

  index title: 'Поверхи' do
    selectable_column
    column :id
    column t('active_admin.user.column.side') do |f|
      f.side == 'left' ? 'Ліве' : 'Праве'
    end
    column t('active_admin.user.column.number')
    column t('active_admin.floors.block') do |float|
      blocks = float.blocks
      array =  blocks.map { |b| "<br>#{link_to b.number, admin_block_path(b)} (#{b.available? ? 'доступні' : 'зайнятий'})" }
      array[0] = array[0].split('<br>').last if array[0]
      raw array.to_sentence
    end
    actions
  end

  show do
    panel "Блоки" do
      table_for floor.blocks do
        column :id
        column :status do |b|
          b.available? ? 'Доступний' : 'Не доступний'
        end
        column :rooms do |b|
          b.rooms.each do |r|
            link_to r.room_type ? '2m' : '3m', admin_room_path(r)
          end
        end
        column :visit do |b|
          link_to 'Переглянути', admin_block_path(b)
        end
      end
    end
    panel "Кімнати" do
      table_for floor.blocks.map { |b| b.rooms}.flatten do
        column :id
        column :status do |room|
          room.available? ? 'Доступна' : 'Не доступна'
        end
        column :room_type do |room|
           room.small? ? '2m' : '3m'
        end
        column :block
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
