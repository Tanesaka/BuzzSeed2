class AddBeginnerColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :beginner, :boolean, default: true, null: false
  end
end
