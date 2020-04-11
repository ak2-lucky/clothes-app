class AddColumnToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :picture, :string
    add_column :posts, :product_name, :string
  end
end
