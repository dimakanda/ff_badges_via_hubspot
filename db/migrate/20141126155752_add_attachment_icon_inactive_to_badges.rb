class AddAttachmentIconInactiveToBadges < ActiveRecord::Migration
  def self.up
    change_table :badges do |t|
      t.attachment :icon_inactive
    end
  end

  def self.down
    remove_attachment :badges, :icon_inactive
  end
end
