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
      link_to "#{b.number} 2м", admin_room_path(room)
    end
    column t('active_admin.blocks.big_room') do |b|
      room = b.rooms.where(room_type: 'big').first
      link_to "#{b.number} 3м", admin_room_path(room)
    end
    actions
  end
end
