class CreateInformation < ActiveRecord::Migration[5.2]
  def change
    create_table :information do |t|
      t.string :content
      t.string :admin_id

      t.timestamps
    end
  end
end
