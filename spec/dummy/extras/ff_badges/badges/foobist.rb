module FfBadges::Badges::Foobist

  def deserves_foobist_badge?
    self.name.include? 'Foo'
  end

  def foobist_badge_percent
    self.name.include?('Foo') ? 100 : 0
  end

end
