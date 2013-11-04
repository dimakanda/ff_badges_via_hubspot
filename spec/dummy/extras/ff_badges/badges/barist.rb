module FfBadges::Badges::Barist

	def deserves_barist_badge?
		self.name.include? 'Bar'
	end

end

