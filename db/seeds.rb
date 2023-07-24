# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
unless Rails.env.production?
  AdminUser.create!(email: 'xxmolekula@gmail.com', password: 'xxmolekula@gmail.com', password_confirmation: 'xxmolekula@gmail.com')

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

end

10.times do |i|
  User.find_or_create_by(email: "user#{i}@example.com") do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
    user.first_name = "First#{i}"
    user.surname = "Surname#{i}"
    user.last_name = "Last#{i}"
    user.region = "Region#{i}"
    user.district = "District#{i}"
    user.city = "City#{i}"
    user.street = "Street#{i}"
    user.house_number = "#{i}"
    user.passport_series = "Series#{i}"
    user.who_issued_the_passport = "Issuer#{i}"
    user.when_issued_the_passport = Date.today - i.years
    user.the_taxpayer_identification_number = "TaxNumber#{i}"
    user.phone_number = "PhoneNumber#{i}"
    user.account_status = i % 2 # alternating between 0 and 1
  end
end


10.times do |i|
  Tenant.find_or_create_by(phone_number: "PhoneNumber#{i}") do |tenant|
    tenant.first_name = "First#{i}"
    tenant.surname = "Surname#{i}"
    tenant.last_name = "Last#{i}"
    tenant.index = "Index#{i}"
    tenant.region = "Region#{i}"
    tenant.district = "District#{i}"
    tenant.city = "City#{i}"
    tenant.street = "Street#{i}"
    tenant.house_number = "#{i}"
    tenant.passport_series = "Series#{i}"
    tenant.who_issued_the_passport = "Issuer#{i}"
    tenant.when_issued_the_passport = Date.today - i.years
    tenant.the_taxpayer_identification_number = "TaxNumber#{i}"
    tenant.login_code = "LoginCode#{i}"
    tenant.user = User.find_by(email: "user#{i}@example.com") # assuming users are already created
  end
end
