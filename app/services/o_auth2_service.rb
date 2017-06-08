class OAuth2Service
  attr_reader :client

  def initialize(params)
    authorization = params.delete(:authorization)
    @client = Signet::OAuth2::Client.new(client_params.merge(params))
    @client.update!(authorization) if authorization.present?
  end

  private

  def client_params
    {
      client_id: Rails.application.secrets.google_client_id,
      client_secret: Rails.application.secrets.google_client_secret,
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      grant_type: "refresh_token"
    }
  end
end