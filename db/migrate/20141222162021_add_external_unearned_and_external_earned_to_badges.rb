class AddExternalUnearnedAndExternalEarnedToBadges < ActiveRecord::Migration

  def change
    change_table :badges do |t|
      t.rename :external_description, :external_earned_description
      t.text :external_unearned_description, after: :external_earned_description
    end
  end
end
