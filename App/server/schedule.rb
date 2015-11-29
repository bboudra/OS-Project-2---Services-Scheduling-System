class Schedule
  include Singleton
  include MonitorMixin
  def initialize
    @schedule = {}
  end

  def get_free_times(date, appointment_length)
    self.synchronize do
      @schedule[date] = Day.new unless @schedule.has_key?(date)
      return @schedule[date].get_free_times(appointment_length)
    end
  end

  def set_appointment(date, appointment_length)
    self.synchronize do
      @schedule[date] = Day.new unless @schedule.has_key?(date)
      @schedule[date].add_appointment(appointment_length)
    end
  end
end
