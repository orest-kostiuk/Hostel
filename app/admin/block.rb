ActiveAdmin.register Block do
  permit_params :side

  filter :floor, collection: -> {
    Floor.all.map { |f| ["#{f.side == 'left' ? "Ліве" : 'Праве'}-#{f.number}", f.id] }
  }

  index do
    selectable_column
    column :number do |b|
      link_to b.number, admin_block_path(b)
    end
    column :small_room do |b|
      room = b.rooms.where(room_type: 'small').first
      link_to "#{b.number} 2м", admin_room_path(room)
    end
    column :big_room do |b|
      room = b.rooms.where(room_type: 'big').first
      link_to "#{b.number} 3м", admin_room_path(room)
    end
    actions
  end
end
