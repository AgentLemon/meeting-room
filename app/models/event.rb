class Event
  def initialize(google_obj)
    @google_obj = google_obj
  end

  def summary
    @google_obj.summary
  end

  def start
    @start ||= convert_time(@google_obj.start.date_time)
  end

  def end
    @end ||= convert_time(@google_obj.end.date_time)
  end

  def start_str
    @start_str ||= format_time(start)
  end

  def end_str
    @end_str ||= format_time(self.end)
  end

  private

  def convert_time(time)
    TimeService.today_at(time.hour, time.min, time.zone).in_time_zone("Europe/Samara")
  end

  def format_time(time)
    time.strftime("%l:%M%P")
  end
end