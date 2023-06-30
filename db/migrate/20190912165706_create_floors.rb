# frozen_string_literal: true

class CreateFloors < ActiveRecord::Migration[5.2]
  def change
    create_table :floors do |t|
      t.integer :side
      t.integer :number
      t.timestamps
    end
  end
end
