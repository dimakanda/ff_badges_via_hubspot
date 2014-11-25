module FfBadges::Badges::Forgetful

  def deserves_forgetful_badge?
    self.reset_password_email_sent_at?
  end

end