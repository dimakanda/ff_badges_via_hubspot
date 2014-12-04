module FfBadges::Badges::Barist

  def deserves_barist_badge?
    self.name.include? 'Bar'
  end

  def barist_badge_percent
    self.name.include?('Bar') ? 100 : 0
  end

end

