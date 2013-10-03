class Badge < ActiveRecord::Base

  has_many :user_badges
  has_many :users, through: :user_badges

	has_attached_file :icon, styles: { big: "200x200#", medium: "73x73#", thumb: "48x48#" }

	validates :name, :message, :icon, :points, :filename, presence: true
	validates :points, numericality: { only_integer: true, greater_than: 0 }
	validates_attachment :icon,
    content_type: { content_type: ['image/gif', 'image/png', 'image/x-png', 'image/jpeg', 'image/pjpeg', 'image/jpg']},
    size: { in: 0..5.megabytes }

  validates :filename, :name, uniqueness: true

end
