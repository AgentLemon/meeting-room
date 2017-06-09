class EventsRenderService
  attr_reader :events

  HEIGHT_MULTIPLIER = 1.5
  PADDING = 2
  TIME_LABEL_SIZE = 10

  def initialize(events_list)
    @events_list = events_list
    @events = events_list.items.find_all{ |e| e.status == "confirmed" }.map{ |e| Event.new(e) }
  end

  def get_day_height
    get_time_height(day_start, day_end)
  end

  def get_style(event)
    "top: #{ get_time_pos_norm(event.start) + 1 }px; height: #{ get_time_height(event.start, event.end) - 3 }px;"
  end

  def render_end_time?(event)
    @events.find{ |e| ( time_in_mins(e.start) - time_in_mins(event.end) ).abs < TIME_LABEL_SIZE }.blank?
  end

  def now_pos
    @now_pos ||= get_time_pos_norm(Time.now.in_time_zone("Europe/Samara"))
  end

  def current?(event)
    get_time_pos_norm(event.start) < now_pos && now_pos < get_time_pos_norm(event.end)
  end

  def grid_full_lines
    @grid_full_lines ||= get_grid_lines(0)
  end

  def grid_half_lines
    @grid_half_lines ||= get_grid_lines(30)
  end

  def empty?
    @events.empty?
  end

  private

  def get_time_pos_norm(time)
    get_time_pos(time) - get_time_pos(day_start)
  end

  def get_time_pos(time)
    ( HEIGHT_MULTIPLIER * time_in_mins(time) ).to_i
  end

  def time_in_mins(time)
    (60 * time.hour + time.min)
  end

  def get_time_height(time_start, time_end)
    get_time_pos(time_end) - get_time_pos(time_start)
  end

  def day_start
    @day_start ||= @events.map(&:start).min
  end

  def day_end
    @day_end ||= @events.map(&:end).max
  end

  def get_grid_lines(minutes)
    positions = []
    cursor = TimeService.today_at(day_start.hour, minutes, day_start.zone)
    while cursor <= day_end do
      positions << cursor if cursor >= day_start
      cursor += 1.hour
    end
    positions.map{ |i| get_time_pos_norm(i) }
  end
end