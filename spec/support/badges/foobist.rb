module FfBadges::Foobist

	extend ActiveSupport::Concern

	def deserves_foobist_badge?
		self.name.include? 'Foo'
	end

end