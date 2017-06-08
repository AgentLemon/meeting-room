class ServerSettings < ApplicationRecord
  self.table_name = "server_settings"

  serialize :token

  def self.token
    ServerSettings.first.token
  end

  def self.token=(value)
    settings = ServerSettings.first || ServerSettings.new
    settings.update_attributes!(token: value)
    value
  end
end
