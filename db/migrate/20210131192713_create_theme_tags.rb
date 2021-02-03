class CreateThemeTags < ActiveRecord::Migration[5.2]
  def change
    create_table :theme_tags do |t|
      t.string :name
      t.string :theme_id

      t.timestamps
    end
  end
end
