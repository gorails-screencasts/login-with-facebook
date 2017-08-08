class Service < ApplicationRecord
  belongs_to :user

  %w{ facebook twitter }.each do |provider|
    scope provider, ->{ where(provider: provider) }
  end

  def client
    send("#{provider}_client")
  end

  def expired?
    expires_at? && expires_at <= Time.zone.now
  end

  def access_token
    send("#{provider}_refresh_token!", super) if expired?
    super
  end

  def facebook_client
    Koala::Facebook::API.new(access_token)
  end

  def facebook_refresh_token!(token)
    new_token_info = Koala::Facebook::OAuth.new.exchange_access_token_info(token)
    update(access_token: new_token_info["access_token"], expires_at: Time.zone.now + new_token_info["expires_in"])
  end
end
