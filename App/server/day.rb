class Day
  ##
  # the times list for that day
  attr_reader :times
  ##
  # that days date
  attr_reader :date
  ##
  #the beginning of that day
  BEGINNING_OF_DAY = 8 * 4 #8 AM military time * 4 15 minute time slots in an hour
  ##
  #The end of That day, following an 8 to 8 schedule
  END_OF_DAY = (20 * 4) - 1 #8 PM military time * 4 15 minute time slots in an hour, -1 because time slot is 7:45 PM to 8:00 PM

  ##
  # The initialization information for that class.
  #
  def initialize(date)
    @date =
        @times = {}
    BEGINNING_OF_DAY.upto(END_OF_DAY) do |x|
      @times[x] = true
    end
  end

  ##
  # the list of free times for an appointment of a given length
  #
  # * *Args* :
  #   - +appointment_length+ -> the length of the appointment
  #
  # * *Returns* :
  #   - the free times for that day object for an appointment of the specified length
  def get_free_times(appointment_length)
    free_times = []
    BEGINNING_OF_DAY.upto(END_OF_DAY) do |current_time_slot|
      current_time_slot
      free = self.is_free_time_slot(current_time_slot, appointment_length)
      if free
        presentable_time = convert_to_presentable_time(current_time_slot)
        free_times.push(presentable_time)
      end
    end
    return free_times
  end

  ##
  # determines whether a particular time_slot is currently free
  #
  # * *Args* :
  #   - +current_time_slot+ -> the desired beginning of the appointment
  #   - +appointment_length+ -> the length of the appointment
  # * *Returns* :
  #   - true if the time slot is free
  #   - false if the time slot is not free
  #
  def is_free_time_slot(current_time_slot, appointment_length)
    appointment_time_slots = (appointment_length.to_i / 0.25).to_i
    current_time_slot.upto(current_time_slot + (appointment_time_slots-1)) do |x|
      if @times.length + 32 < x
        return false
      elsif @times[x] == false
        return false
      end
    end
    return true
  end

  ##
  # Adds a appointment to the schedule given a particular starting time slot and appointment_length
  #
  # * *Args* :
  #   - +time_slot+ -> the starting time slot
  #   - +appointment_length+ -> the lenght of the appointment
  def add_appointment(time_slot, appointment_length)
    appointment_time_slots = appointment_length.to_i*4
    time_slot.upto((time_slot + appointment_time_slots-1)) do |i|
      @times[i] = false
    end
    return true
  end

  ##
  # given a military time time string, converts that string into a time slot
  #
  # * *Args* :
  #   - +string_military_time+ -> the time string to be converted
  # * *Returns*
  #   - the time string as a float
  def convert_to_time_slot_from_string_time(string_military_time)
    array_military_time = string_military_time.split(":")
    float_military_time = "#{array_military_time[0]}.#{array_military_time[1]}".to_f
    puts float_military_time
    converted_float_time = float_military_time.to_i.to_f + (float_military_time.to_f - float_military_time.to_i.to_f ) *10.0/6.0
    puts converted_float_time
    return (converted_float_time * 4.0).to_i
  end


  ##
  # coverts the time as a float into the military time-string
  #
  # * *Args* :
  #   - +time+ -> the time as a float
  #
  # * *Returns* :
  #   - the time as a string
  def convert_to_presentable_time(time)
    hours = time / 4
    minutes = (((time.to_f / 4.0) - (time / 4).to_f) * 60).round()
    presentable_time = "#{hours}:#{minutes}"
    return presentable_time
  end
end
=begin
@day = Day.new"12,12,2015"
puts 42 == @day.convert_to_time_slot_from_string_time("10:30")
puts 74 == @day.convert_to_time_slot_from_string_time("18:30")
puts 79 == @day.convert_to_time_slot_from_string_time("19:45")
=end
