class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name, null: false
      t.text :description
      t.text :message
      t.string :filename, null: false
      t.integer :points, unsigned: true
      t.attachment :icon

      t.timestamps
    end
  end
end
