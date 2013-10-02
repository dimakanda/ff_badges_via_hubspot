class CreateUserBadges < ActiveRecord::Migration
  def change
    create_table :user_badges do |t|
      t.integer :user_id, null: false
      t.integer :badge_id, null: false
      t.timestamps
    end

    add_index :user_badges, :user_id, unique: false
  end
end
