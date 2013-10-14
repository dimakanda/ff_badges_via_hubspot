module FfBadges::Forgetful

	extend ActiveSupport::Concern

	def deserves_forgetful_badge?
		self.reset_password_email_sent_at?
	end

end