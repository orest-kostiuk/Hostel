# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# AdminUser.create!(email: 'xxmolekula@gmail.com', password: 'xxmolekula@gmail.com', password_confirmation: 'xxmolekula@gmail.com')

left = 9.times.map do |i|
  Floor.create(side: 'left', number: i + 1)
end
right = 9.times.map do |i|
  Floor.create(side: 'right', number: i + 1)
end

left_blocks = left.map do |floor|
  6.times.map do |i|
    floor.blocks.create(number: "#{floor.number}0#{i + 1}")
  end
end

right_blocks = right.map do |floor|
  6.times.map do |i|
    floor.blocks.create(number: "#{floor.number}0#{i + 1}")
  end
end

floors = right_blocks + left_blocks

floors.each do |f|
  f.each do |b|
    2.times.each do |i|
      b.rooms.create(room_type: i)
    end
  end
end
months = %w[Січень Лютий Березень Квітень Травень Червернь Липень Серпень Вересень Жовтень Листопад Грудень]
months.each do |name|
  Month.create(name: name)
end
