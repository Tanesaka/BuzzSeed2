class Add2ColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_active, :boolean, default: true, null: false
  end
end
