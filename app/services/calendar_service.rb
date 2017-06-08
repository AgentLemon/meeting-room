class CalendarService
  attr_reader :service

  def initialize
    @client = OAuth2Service.new(authorization: ServerSettings.token).client
    @service = Google::Apis::CalendarV3::CalendarService.new
    @service.authorization = @client
  end

  def list_calendar_lists
    with_token_refresh{ @service.list_calendar_lists }
  end

  def list_events(calendar_id, params)
    with_token_refresh{ @service.list_events(calendar_id, params) }
  end

  private

  def with_token_refresh(&block)
    begin
      yield
    rescue Google::Apis::AuthorizationError => exception
      response = @client.refresh!
      ServerSettings.token = ServerSettings.token.merge(response)
      retry
    end
  end
end
