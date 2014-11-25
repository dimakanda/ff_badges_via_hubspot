class UpdateBadgesFields < ActiveRecord::Migration
  def change
    rename_column :badges, :description, :external_description
    add_column :badges, :internal_description, :text, after: :external_description
    add_column :badges, :secret, :boolean, after: :internal_description, default: false
  end

end
