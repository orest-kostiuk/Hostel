class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :short_description
      t.text :body
      t.integer :admin_user_id

      t.timestamps
    end
  end
end
