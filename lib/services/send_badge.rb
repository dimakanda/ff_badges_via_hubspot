module Services
  class SendBadge
    def self.send_badge_email(user, badge)
      @user = user
      @badge = badge
      @user_badge = UserBadge.where(user_id: @user, badge_id: @badge).first
      auth = "Bearer " + ENV['HUBSPOT_ACCESS_TOKEN']
      HTTParty.post("https://api.hubapi.com/email/public/v1/singleEmail/send", 
                    :headers => { "Authorization" => auth, 'Content-Type' => 'application/json'},
                    :body => {"emailId": "86843079695",
                            "message": {"to": @user[:email], "from": %("Write the World" <support@writetheworld.org>)},
                            "customProperties": [
                                                    {
                                                        "name": "badge_name",
                                                        "value": @badge.name
                                                    },
                                                    {
                                                        "name": "badge_message",
                                                        "value": @badge.message
                                                    },
                                                    {
                                                        "name": "username",
                                                        "value": @user[:name]
                                                    },

                                                 ]}.to_json)
    end
  end
end
