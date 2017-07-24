class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    service = Service.where(provider: auth.provider, uid: auth.uid).first

    # Look up existing user with this facebook account
    if service.present?
      user = service.user
      service.update(
        expires_at: Time.at(auth.credentials.expires_at),
        access_token: auth.credentials.token,
      )

    else
      user = User.create(
        email: auth.info.email,
        #name: auth.info.name,
        password: Devise.friendly_token[0,20]
      )

      user.services.create(
        provider: auth.provider,
        uid: auth.uid,
        expires_at: Time.at(auth.credentials.expires_at),
        access_token: auth.credentials.token,
      )

    end

    sign_in_and_redirect user, event: :authentication
    set_flash_message :notice, :success, kind: "Facebook"
  end

  def auth
    request.env['omniauth.auth']
  end
end

#<OmniAuth::AuthHash
#credentials=#<OmniAuth::AuthHash expires=true expires_at=1506091894 token="EAABflKwUrhQBABqzaa8vayyVVTspYhjEN4ixhFGdgxSA6XXvFmylyyA6nDzWE4lmqPT31ZAKNJrRKZBylQQysaB1VsoGVRyaPVfihnsKIcVna4WAlzZAfo3DCTc02RFjgz0LF3NlZB8io0OUeSTvL1lDGfDv5zNhQ5vJSiXphQZDZD"> extra=#<OmniAuth::AuthHash raw_info=#<OmniAuth::AuthHash email="excid3@gmail.com" id="1225015704269784" name="Chris Oliver">> info=#<OmniAuth::AuthHash::InfoHash email="excid3@gmail.com" image="http://graph.facebook.com/v2.6/1225015704269784/picture" name="Chris Oliver"> provider="facebook" uid="1225015704269784">
