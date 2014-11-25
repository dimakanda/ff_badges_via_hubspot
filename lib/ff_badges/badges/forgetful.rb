module FfBadges::Badges::Forgetful

  @@forgetful_is_gem_badge = true

  def deserves_forgetful_badge?
    self.reset_password_email_sent_at?
  end

end