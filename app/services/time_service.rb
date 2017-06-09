class TimeService
  def self.today_at(hour, min, zone)
    today = Date.today
    DateTime.new(today.year, today.month, today.day, hour, min, 0, zone)
  end
end
