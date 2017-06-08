class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:init, :callback]

  def init
    service = OAuth2Service.new(scope: Google::Apis::CalendarV3::AUTH_CALENDAR, redirect_uri: callback_url)
    client = service.client
    redirect_to client.authorization_uri.to_s
  end

  def callback
    service = OAuth2Service.new(redirect_uri: callback_url, code: params[:code])
    client = service.client
    response = client.fetch_access_token!
    ServerSettings.token = response
    redirect_to calendars_url
  end
  
  def calendars
    @calendar_list = CalendarService.new.list_calendar_lists
    render json: @calendar_list
  end

  def events
    @event_list = CalendarService.new.list_events(
      "cloudcastlegroup.com_2d3539313231353732323334@resource.calendar.google.com",
      time_min: DateTime.now.beginning_of_day.rfc3339,
      time_max: DateTime.now.end_of_day.rfc3339
    )
    render json: @event_list
  end
end