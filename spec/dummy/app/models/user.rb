class User < ActiveRecord::Base

  attr_accessor :skip_activation_email

  authenticates_with_sorcery!

  has_many :user_badges
  has_many :badges, through: :user_badges

  def send_activation_needed_email!
    super unless skip_activation_email
  end

  def active?
    self.activation_state == "active"
  end

end