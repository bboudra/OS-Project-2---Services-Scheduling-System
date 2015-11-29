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

  def set_appointment(date,appointment_length, start_time)
    @lock.synchronize do
      @schedule[date] = Day.new(date) unless @schedule.has_key?(date)
      time_slot = @schedule[date].convert_to_time_slot_from_string_time(start_time)
      if @schedule[date].is_free_time_slot(time_slot,appointment_length)
        @schedule[date].add_appointment(time_slot,appointment_length)
        return 'The operation was successful, you are now registered for your appointment.'
      else
        return 'Sorry, that time is no longer available, please try again.'
      end
    end
  end
end

