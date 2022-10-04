module FfBadgesHelper

  def notice_earned_badges
    if @ff_badge
      app_badges_modal_path = 'extras/ff_badges/views/modal'

      # if modal defined in app_partial_path than use it, otherwise use partial form engine
      if defined? @@app_badges_modal_path || File.exists?("#{app_badges_modal_path}.html.erb")
        @@app_badges_modal_path ||= app_badges_modal_path # cache path in class variable
        render file: @@app_badges_modal_path, locals: { badge: @ff_badge }
      else
        render template: 'shared/badges_modal', locals: { badge: @ff_badge }
      end
    end
  end
end
