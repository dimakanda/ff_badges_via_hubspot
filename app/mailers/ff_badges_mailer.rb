class FfBadgesMailer < ActionMailer::Base

  layout 'email'
  default from: ENV.has_key?('DEFAULT_FROM_EMAIL') ? ENV['DEFAULT_FROM_EMAIL'] : %("Write the World" <support@writetheworld.com>)

  def badge_earned_email(user, badge)
    @user = user
      @badge = badge
      @user_badge = UserBadge.where(user_id: @user, badge_id: @badge).first
      auth = "Bearer " + ENV['HUBSPOT_ACCESS_TOKEN']
      HTTParty.post("https://api.hubapi.com/email/public/v1/singleEmail/send", 
                    :headers => { "Authorization" => auth, 'Content-Type' => 'application/json'},
                    :body => {"emailId": "86843079695",
                              "message": {"to": @user.email},
                              "contactProperties": [
                                                      {
                                                        "name": "badgename",
                                                        "value": @badge.name
                                                      },
                                                      {
                                                        "name": "message",
                                                        "value": @badge.message
                                                      }
                                                   ]})
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