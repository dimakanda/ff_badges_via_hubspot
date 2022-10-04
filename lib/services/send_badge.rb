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
                            "message": {"to": @user[:email], "from": "noreply@hubspot.com"},
                            "customProperties": [
                                                    {
                                                        "name": "item_1",
                                                        "value": @badge.name
                                                    },
                                                    {
                                                        "name": "item_2",
                                                        "value": @badge.message
                                                    },
                                                    {
                                                        "name": "item_3",
                                                        "value": @user[:name]
                                                    },

                                                 ]}.to_json)
    end
  end
end