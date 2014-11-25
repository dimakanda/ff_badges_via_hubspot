class Badge < ActiveRecord::Base

  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  has_attached_file :icon, styles: { big: "200x200#", medium: "73x73#", thumb: "48x48#" },
    path: ":rails_root/public/system/badges/icons/:id_partition/:style/:filename",
    url: "/system/badges/icons/:id_partition/:style/:filename"

  validates_presence_of :name, :message, :icon, :filename
  validates :points, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
  validates_attachment :icon,
    content_type: { content_type: ['image/gif', 'image/png', 'image/x-png', 'image/jpeg', 'image/pjpeg', 'image/jpg']},
    size: { in: 0..5.megabytes }
  validates :invertable, inclusion: {in: [true, false]}
  validates :secret, inclusion: {in: [true, false]}

  validates_uniqueness_of :filename, :name
  validates :filename, format: { with: /\A[a-z0-9_]+\z/, message: "has wrong format" }

  scope :secret, -> { where(secret: true) }
  scope :not_secret, -> { where(secret: false) }

  def self.badge_configured?(filename)
    Badge.where(filename: filename).exists?
  end

end
