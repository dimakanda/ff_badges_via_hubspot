class AddInvertableToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :invertable, :boolean, default: false, after: :points
  end
end
