class AddColumnToInfomation < ActiveRecord::Migration[5.2]
  def change
    add_column :infomations, :admin_id, :string
  end
end
