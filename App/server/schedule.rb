require 'thread'
require 'date'
require_relative 'day'
class Schedule
  @@schedule = {}
  def initialize
    @@lock = Mutex.new
  end

  ##
  # Given a specific date and appointment length, retrieves the list of free times for that appointment length and that date and returns them to the caller
  #
  # * *Args* :
  #   - +date+ -> the date of the appointment
  #   - +length+ -> the length of the appointment
  #
  # * *Returns* -> the times that are available to register to the user
  #
  def get_free_times(date, appointment_length)
    @@lock.synchronize do
      @@schedule[date] = Day.new(date) unless @@schedule.has_key?(date)
      return @@schedule[date].get_free_times(appointment_length.to_f).push('End Of Message')
    end
  end

  ##
  # Given a specific date, appointment length, and start_time, registers the user for an appointment if one doesn't already exist at the point of being called.
  #
  # * *Args# :
  #   - +date+ -> the date of the appointment
  #   - +appointment_length+ -> the length of the appointment
  #   - +start_time+ -> the start time of the appointment
  #
  def set_appointment(date,appointment_length, start_time)
    @@lock.synchronize do
      @@schedule[date] = Day.new(date) unless @@schedule.has_key?(date)
      time_slot = @@schedule[date].convert_to_time_slot_from_string_time(start_time)
      if @@schedule[date].is_free_time_slot(time_slot,appointment_length)
        @@schedule[date].add_appointment(time_slot,appointment_length)
        return 'The operation was successful, you are now registered for your appointment.'
      else
        return 'Sorry, that time is no longer available, please try again.'
      end
    end
  end
end

