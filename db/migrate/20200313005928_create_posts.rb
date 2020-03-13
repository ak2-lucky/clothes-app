class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :context
      t.references :user, foreign_key: true
      t.string :brand
      t.string :category
      t.float :rate
      t.string :sex

      t.timestamps
    end
  end
end
