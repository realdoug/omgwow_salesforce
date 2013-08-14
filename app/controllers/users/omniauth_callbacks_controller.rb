class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def salesforce
    # This is where you process the user information coming back from salesforce.
    puts "USER USER INFO: #{request.env["omniauth.auth"].to_yaml}"
    user = User.where( uid: request.env["omniauth.auth"]["extra"]["user_id"]).first
    unless user
      user = User.create!(
        uid: request.env["omniauth.auth"]["extra"]["user_id"],
        email: request.env["omniauth.auth"]["info"]["email"],
        password: Devise.friendly_token[0,20],
        name: "#{request.env["omniauth.auth"]["info"]["first_name"]} #{request.env["omniauth.auth"]["info"]["last_name"]}"
      )
    end
    sign_in_and_redirect user, :event => :authentication
  end
end