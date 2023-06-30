# frozen_string_literal: true

class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :surname, :string
    add_column :users, :last_name, :string
    add_column :users, :index, :string
    add_column :users, :region, :string
    add_column :users, :district, :string
    add_column :users, :city, :string
    add_column :users, :street, :string
    add_column :users, :house_number, :string
    add_column :users, :passport_series, :string
    add_column :users, :who_issued_the_passport, :string
    add_column :users, :when_issued_the_passport, :date
    add_column :users, :the_taxpayer_identification_number, :string
    add_column :users, :phone_number, :string
    add_column :users, :account_status, :integer, default: 0
  end
end
