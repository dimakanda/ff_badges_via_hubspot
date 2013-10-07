FactoryGirl.define do

  factory :user do
    sequence(:name) {|n| "User#{n}" }
    sequence(:email) {|n| "user#{n}@base_app.com" }
    password "secret"
    activation_state "active"
  end

  factory :administrator, parent: :user do
    sequence(:name) {|n| "Administrator#{n}" }
    sequence(:email) {|n| "administrator#{n}@base_app.com" }
    admin true
  end

  factory :badge do
    sequence(:name) {|n| "BadgeName#{n}" }
    sequence(:description) {|n| "BadgeDescription#{n}" }
    sequence(:message) {|n| "BadgeDescription#{n}" }
    sequence(:filename) {|n| "badge_filename_#{n}" }
    points 10
    #icon { fixture_file_upload(File.join(Rails.root, '../', 'fixtures', 'picture.png')) }
    icon_file_name { 'badge.jpg' }
    icon_content_type { 'image/jpeg' }
    icon_file_size { 33344 }
  end
  
end
