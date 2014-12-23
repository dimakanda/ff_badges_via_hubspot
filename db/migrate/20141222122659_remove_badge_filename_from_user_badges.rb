class RemoveBadgeFilenameFromUserBadges < ActiveRecord::Migration
  def change
    remove_index :user_badges, [:user_id, :badge_filename]
    remove_column :user_badges, :badge_filename
  end
end
