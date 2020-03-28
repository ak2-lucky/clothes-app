class RenameContextColumnToPosts < ActiveRecord::Migration[5.1]
  def change
    rename_column :posts, :context, :content
  end
end
