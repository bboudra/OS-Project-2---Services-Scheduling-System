require 'thread'
require 'date'
require_relative 'day'
class Schedule
  def initialize
    @schedule = {}
    @lock = Mutex.new
  end

  def get_free_times(date, appointment_length)
    @lock.synchronize do
      @schedule[date] = Day.new(date) unless @schedule.has_key?(date)
      return @schedule[date].get_free_times(appointment_length.to_f).push('End Of Message')
    end
  end

  def set_appointment(date, appointment_length)
    @lock.synchronize do
      @schedule[date] = Day.new(date) unless @schedule.has_key?(date)
      @schedule[date].add_appointment(appointment_length)
    end
  end
end

