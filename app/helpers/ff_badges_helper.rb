module FfBadgesHelper

	def notice_earned_badges
		if @ff_badge
			app_partial_path = 'extras/ff_badges/views/modal.html.erb' 
			
			# if modal defined in app_partial_path than use it, otherwise use partial form engine
			if File.exists?(app_partial_path) 
				render file: app_partial_path, locals: { badge: @ff_badge }
			else
				render template: 'shared/badges_modal', locals: { badge: @ff_badge }
			end
		end
	end

end