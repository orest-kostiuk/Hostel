# frozen_string_literal: true

class CreateTenants < ActiveRecord::Migration[5.2]
  def change
    create_table :tenants do |t|
      t.string :first_name
      t.string :surname
      t.string :last_name
      t.string :index
      t.string :region
      t.string :district
      t.string :city
      t.string :street
      t.string :house_number
      t.string :passport_series
      t.string :who_issued_the_passport
      t.date :when_issued_the_passport
      t.string :the_taxpayer_identification_number
      t.string :phone_number
      t.string :login_code

      t.timestamps
    end
  end
end
