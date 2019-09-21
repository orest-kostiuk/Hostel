class CreateCredentials < ActiveRecord::Migration[5.2]
  def change
    create_table :credentials do |t|
      t.integer :name
      t.integer :int_value
      t.string :str_value
      t.belongs_to :admin_user
      t.timestamps
    end
  end
end
