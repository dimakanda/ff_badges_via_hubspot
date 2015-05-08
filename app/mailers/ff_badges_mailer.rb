class FfBadgesMailer < ActionMailer::Base

  layout 'email'
  default from: ENV.has_key?('DEFAULT_FROM_EMAIL') ? ENV['DEFAULT_FROM_EMAIL'] : %("Write the World" <support@writetheworld.com>)

  def badge_earned_email(user, badge)
    @user = user
    if @user.badgable?
      @badge = badge
      @user_badge = UserBadge.where(user_id: @user, badge_id: @badge).first
      mail(to: @user.email,
           subject: "You have earned #{@badge.name} badge.") do |format|
        format.html { render file: File.join(mail_template_path, 'badge_earned_email.html.erb') }
        format.text { render file: File.join(mail_template_path, 'badge_earned_email.text.erb') }
      end
    end
  end

  private

  def mail_template_path
    mail_template_path = 'ff_badges/badges_mailer'

    if lookup_context.template_exists?("badge_earned_email", lookup_context.prefixes, false)
      mail_template_path
    else
      'ff_badges_mailer'
    end
  end
end