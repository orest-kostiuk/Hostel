ActiveAdmin.register Floor do
  permit_params :side
  menu label: "Поверхи"

  scope :floor_1 do
    Floor.where(number: 1)
  end

  scope :floor_2 do
    Floor.where(number: 2)
  end

  scope :floor_3 do
    Floor.where(number: 3)
  end

  scope :floor_4 do
    Floor.where(number: 4)
  end

  scope :floor_5 do
    Floor.where(number: 5)
  end

  scope :floor_6 do
    Floor.where(number: 6)
  end

  scope :floor_7 do
    Floor.where(number: 7)
  end

  scope :floor_8 do
    Floor.where(number: 8)
  end

  scope :floor_9 do
    Floor.where(number: 9)
  end

  index do
    selectable_column
    column :id
    column :side do |f|
      f.side == 'left' ? "Ліве" : 'Праве'
    end
    column :number
    column :blocks do |float|
      blocks = float.blocks
      array =  blocks.map { |b| "<br>#{link_to b.number, admin_block_path(b)} (#{b.available? ? 'доступні' : 'зайнятий'})" }
      array[0] = array[0].split('<br>').last if array[0]
      raw array.to_sentence
    end
    actions
  end
end
