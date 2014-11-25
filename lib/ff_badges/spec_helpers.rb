module FfBadges::SpecHelpers

  def badge_check_modal(badge)
    within '#ff_badges_modal' do
      expect(page).to have_content badge.name
      expect(page).to have_content badge.message
    end
  end

  def badge_check_email(badge)
    emails_data = ActionMailer::Base.deliveries.collect {|e| [e.to, e.subject]}

    expect(emails_data).to include([[user.email], "You have earned #{badge.name} badge."])
  end

  def badge_check_page_content(badge)
    expect(page).to have_content badge.name
    expect(page).to have_image badge.icon.url(:big)
    expect(page).to have_content badge.external_description
    expect(page).not_to have_content badge.internal_description
  end

end