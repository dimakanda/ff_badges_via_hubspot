class User < ActiveRecord::Base

  attr_accessor :skip_activation_email

  authenticates_with_sorcery!

  include Concerns::FfBadges::User
  badges :forgetful

  def send_activation_needed_email!
    super unless skip_activation_email
  end

  def active?
    self.activation_state == "active"
  end

end