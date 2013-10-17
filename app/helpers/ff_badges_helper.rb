module FfBadgesHelper

	def notice_earned_badges
		if @ff_badge
			render partial: 'shared/badges_modal', locals: { badge: @ff_badge }
		end
	end

end