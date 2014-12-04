module FfBadges::Badges::Forgetful

  def deserves_forgetful_badge?
    self.reset_password_email_sent_at?
  end

  def forgetful_badge_percent
    self.reset_password_email_sent_at? ? 100 : 0
  end

end