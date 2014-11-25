class AddBadgeFilenameToUserBadges < ActiveRecord::Migration
  def change
    add_column :user_badges, :badge_filename, :string, null: false, after: :badge_id

    UserBadge.reset_column_information
    UserBadge.all.each do |ub|
      if badge = Badge.where(id: ub.badge_id).first
        ub.update_column :badge_filename, badge.filename
      end
    end

    add_index :user_badges, [:user_id, :badge_filename], unique: true
    add_index :user_badges, [:user_id, :badge_id], unique: true
  end

end
