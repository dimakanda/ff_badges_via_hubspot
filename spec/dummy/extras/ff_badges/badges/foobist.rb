module FfBadges::Badges::Foobist

	def deserves_foobist_badge?
		self.name.include? 'Foo'
	end

end
