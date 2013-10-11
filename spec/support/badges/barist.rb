module FfBadges::Barist

	extend ActiveSupport::Concern

	def deserves_barist_badge?
		self.name.include? 'Bar'
	end

end