module FfBadgesHelper

	def notice_earned_badges
		if @ff_badge
			render partial: 'shared/badges_modal'
		end
	end

end